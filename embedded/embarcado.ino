#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <ESP8266HTTPClient.h>
#include "DHTesp.h"
#include <Wire.h>
#include <Adafruit_BMP085.h>

ESP8266WebServer server(80);

// credenciais de acesso à rede
const char* ssid = "APTO206_2.4G";
const char* password = "05090302";

// Endereço do servidor para qual as informações serão enviadas
const char* serverName = "http://3.134.102.171:3000/measure";

// tempo medido em milisegundos
unsigned long lastTime = 0;
unsigned long timerDelay = 60 * 60 * 1000;

DHTesp dht; 
Adafruit_BMP085 bmp;

void handle_index() {
// Read sensor data
  float moisture = dht.getHumidity();
  float temperature_dht22 = dht.getTemperature();
  float temperature_bmp180 = bmp.readTemperature();
  float pressure = bmp.readPressure() / 100.0;
  float seaLevelPressure = bmp.readSealevelPressure() / 100.0;
  float altitude = bmp.readAltitude();

  // Create a JSON string with the sensor data
  String jsonData = "{";
  jsonData += "\"moisture\": " + String(moisture, 2) + ",";
  jsonData += "\"temperature_dht22\": " + String(temperature_dht22, 2) + ",";
  jsonData += "\"temperature_bmp180\": " + String(temperature_bmp180, 2) + ",";
  jsonData += "\"pressure\": " + String(pressure, 2);
  jsonData += "}";

  // Create an HTML document with the JSON data
  String htmlData = "<html><head><title>Sensor Data</title></head><body>";
  htmlData += "<h1>Dados dos sensores</h1>";
  htmlData += "<p>JSON Data: " + jsonData + "</p>";
  htmlData += "<p>Temperature: " + String(temperature_dht22, 2) + " *C (Grau Celsius)</p>";
  htmlData += "<p>Pressure: " + String(pressure, 2) + " hPa (Pascal)</p>";
  htmlData += "<p>Altitude: " + String(altitude, 2) + " m (Metros)</p>";
  htmlData += "<p>Sea Level Pressure: " + String(seaLevelPressure, 2) + " hPa (Pascal)</p>";
  htmlData += "</body></html>";

  server.send(200, "text/html", htmlData);
}

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("Aguardando conexão...");
  }

  dht.setup(D7, DHTesp::DHT22);
  if (!bmp.begin()){
    Serial.println("Sensor BMP180 não foi identificado! Verifique as conexões.");
    while(1){}
  }

  Serial.print("Endereço IP: ");
  Serial.println(WiFi.localIP());

  server.on("/", handle_index);

  server.begin();
  Serial.println("Server listening");
}

void loop() {
  server.handleClient();

  // Verifica se já passou o delay entre uma leitura e outra
  if ((millis() - lastTime) > timerDelay) {
    // Verifica se o wifi está conectado
    if(WiFi.status() == WL_CONNECTED){
      WiFiClient client;
      HTTPClient http;
    
      // Conecta o cliente com o servidor
      http.begin(client, serverName);

      // Lê as informações dos sensores
      float moisture = dht.getHumidity();
      float temperature_dht22 = dht.getTemperature();
      float temperature_bmp180 = bmp.readTemperature();
      float pressure = bmp.readPressure() / 100.0;
      float seaLevelPressure = bmp.readSealevelPressure() / 100.0;

      // Cria um json com as informações lidas
      String jsonData = "{";
      jsonData += "\"moisture\": " + String(moisture, 2) + ",";
      jsonData += "\"temperature_dht22\": " + String(temperature_dht22, 2) + ",";
      jsonData += "\"temperature_bmp180\": " + String(temperature_bmp180, 2) + ",";
      jsonData += "\"pressure\": " + String(pressure, 2);
      jsonData += "}";
      
      http.addHeader("Content-Type", "application/json");

      // envia as informações para o servidor
      int httpResponseCode = http.POST(jsonData);
     
      Serial.print("Código de resposta HTTP: ");
      Serial.println(httpResponseCode);
  
      http.end();
    }
    else {
      Serial.println("WiFi Desconectado");
    }
    lastTime = millis();
  }
}