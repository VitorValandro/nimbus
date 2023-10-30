import { Type } from 'class-transformer';
import { IsInt, IsOptional, Min } from 'class-validator';

export class GetAllMeasuresQueryParams {
  @IsOptional()
  @Type(() => Number)
  @IsInt({ message: 'The skip param must be an integer number' })
  @Min(0, { message: 'The skip param must be 0 or a positive integer' })
  skip?: number = 0;

  @IsOptional()
  @Type(() => Number)
  @IsInt({ message: 'The take param must be an integer number' })
  @Min(1, { message: 'The take param must be greater than 0' })
  take?: number = 10;
}
