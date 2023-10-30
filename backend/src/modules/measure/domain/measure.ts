import { InvalidTimestampDate } from './InvalidDateException';
import { ZambrettiEnum } from '../../shared/domain/zambretti';

export type MeasureProps = {
  id?: string;
  timestamp?: string | number | Date;
  pressure: number;
  moisture: number;
  temperature_dht22: number;
  temperature_bmp180: number;
  zambretti_value?: number;
};

export class MeasureDomain {
  id?: string;
  timestamp: Date;
  pressure: number;
  moisture: number;
  temperature_dht22: number;
  temperature_bmp180: number;
  zambretti?: ZambrettiEnum;

  constructor(data: MeasureProps) {
    this.id = data.id;
    this.timestamp = data.timestamp
      ? MeasureDomain.parseTimestamp(data.timestamp)
      : null;
    this.pressure = data.pressure;
    this.moisture = data.moisture;
    this.temperature_dht22 = data.temperature_dht22;
    this.temperature_bmp180 = data.temperature_bmp180;
    this.zambretti = data.zambretti_value;
  }

  static parseTimestamp(timestamp: string | number | Date): Date {
    const parsedDate = new Date(timestamp);
    if (isNaN(parsedDate.getTime())) throw new InvalidTimestampDate();

    return parsedDate;
  }

  toObject(): Omit<MeasureProps, 'timestamp' | 'zambretti_value'> & {
    timestamp: Date;
    zambretti_value: number;
  } {
    return {
      id: this.id,
      timestamp: this.timestamp,
      pressure: this.pressure,
      moisture: this.moisture,
      temperature_dht22: this.temperature_dht22,
      temperature_bmp180: this.temperature_bmp180,
      zambretti_value: this.zambretti,
    };
  }
}
