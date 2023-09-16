import { InvalidTimestampDate } from './InvalidDateException';

export type MeasureProps = {
  timestamp: string | number | Date;
  pressure: number;
  moisture: number;
  temperature_dht22: number;
  temperature_bmp180: number;
};

export class MeasureDomain {
  timestamp: Date;
  pressure: number;
  moisture: number;
  temperature_dht22: number;
  temperature_bmp180: number;

  constructor(data: MeasureProps) {
    this.timestamp = MeasureDomain.parseTimestamp(data.timestamp);
    this.pressure = data.pressure;
    this.moisture = data.moisture;
    this.temperature_dht22 = data.temperature_dht22;
    this.temperature_bmp180 = data.temperature_bmp180;
  }

  static parseTimestamp(timestamp: string | number | Date): Date {
    const parsedDate = new Date(timestamp);
    if (isNaN(parsedDate.getTime())) throw new InvalidTimestampDate();

    return parsedDate;
  }
}
