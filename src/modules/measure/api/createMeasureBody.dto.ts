import { IsNumber, IsOptional, Min } from 'class-validator';
import { IsValidTimestamp } from '../../../infrastructure/validators/IsValidTimestamp';

export class CreateMeasureBody {
  @IsOptional()
  @IsValidTimestamp({
    message:
      'The timestamp must be a valid timestamp integer or a valid ISO8601 date string',
  })
  timestamp?: number | Date;

  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'The air pressure must be a number' },
  )
  @Min(0, { message: 'The air pressure must be 0 or a positive integer' })
  pressure: number;

  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'The air moisture must be a number' },
  )
  @Min(0, { message: 'The air moisture must be 0 or a positive integer' })
  moisture: number;

  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'The air moisture must be a number' },
  )
  temperature_dht22: number;

  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'The air moisture must be a number' },
  )
  temperature_bmp180: number;
}
