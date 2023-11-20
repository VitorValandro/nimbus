<h1 align="center">
  <img width="256px" src="https://github.com/VitorValandro/nimbus/assets/50156875/82f4870a-c6cd-4f92-91a7-88895404b4c9" />
  <br />
</h1>


<h3 align="center">
A minimalist weather app built from scratch
</h3>

A simple weather forecaster with its own data collecting, processing and displaying. Made with a microcontroller, an overgineered backend and a minimal mobile app.

<div align="center">
  <div align="center">
    <img width="400" src="https://github.com/VitorValandro/nimbus/assets/50156875/498ea962-40a5-4010-9c6e-1346a40057a4">
    <img width="400" src="https://github.com/VitorValandro/nimbus/assets/50156875/90f2e50c-a386-49c4-b0b3-5b3e4dbaeec9">
  </div>

</div>

## About the project
Nimbus is a fundamentals project for weather forecasting. The system is based on an ESP8266 embedded system that uses moisture, temperature and barometric pressure sensors to collect data from the environment and send to a NodeJS web server hosted on AWS. The web server stores this data and processes it using the [Zambretti Algorithm](https://web.archive.org/web/20110610213848/http://www.meteormetrics.com/zambretti.htm) for weather forecasting that is consumed by a Flutter mobile app. The mobile app retrieves the data from the web server and displays it to the user in an human readable way.

I developed this for my Embedded Sytems course at UFSC, and as always ended up complicating it so I could learn something new. The feaures are very simple, just collecting, processing and displaying data, so the focus of this project is not to build something new or really useful, but to learn new technologies, tools and the core concepts of bulding an embedded system from scratch.

### Embedded System
The embedded system is an ESP8266 microcontroller with a DHT22 moisture and temperature sensor and a BMP180 barometric pressure sensor. The project of this system is shown in the image below. The system collects the weather data from the environment using the sensors and then sends it via HTTP to the backend server.

#### ESP8266 PHOTO

There is nothing technically special about this, but it was fun getting my hands on high-level hardware to build it and make it work.

### Backend
The backend is responsible for receiving the data from the ESP8266, store it, process it and then offer a resource for the mobile client to consume.

#### Tech stack
- *TypeScript* as programming language;
- *NodeJS* + NestJS;
- *Prisma* as ORM (what a regret);
- *MongoDB* for the main database;
- *Redis* for caching;
- *AWS EC2* for deployment; 

This was my first project using Redis for caching, so it was a very good opportunity to learn and implement application level caching. This project uses write-through and read-through caching. After this project, I gave up of using Prisma with MongoDB and will give it some time for the relation databases. Prisma is great, but it is still new and there are a lot of limitations.

The main learning of this was DevOps stuff. It is all containerized using docker and docker-compose, things that I already knew but never paid much attention on how things works. With this project I got a much better idea of how it works under the hood. Also, this was the first project I deployed on AWS EC2 on my very own, so this is the major outcome of this project!

### Mobile App
The mobile app consumes the data from the backend and displays it to the user. It is made with Flutter and uses [Lottie](https://lottiefiles.com/) for animations and [fl_chart](https://pub.dev/packages/fl_chart) for drawing the charts.

The design is very minimal but functional, it was my first flutter app made from scratch so I took as an opportunity to know how Dart works under the hood, get to know Dart + Flutter declarative culture and learn how to properly setup a Flutter app.

###### The animations and arts weren't made by me.
###### Vitor Matheus Valandro da Rosa. November 2023.
