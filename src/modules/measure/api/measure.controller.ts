import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import { MeasureService } from '../service/measure.service';
import { GetAllMeasuresQueryParams } from './getAllMeasuresQueryParams.dto';
import { CreateMeasureBody } from './createMeasureBody.dto';
import { MeasureDomain } from '../domain/measure';

@Controller('measure')
export class MeasureController {
  constructor(private readonly measureService: MeasureService) {}

  @Get()
  async getAll(@Query() query: GetAllMeasuresQueryParams) {
    return this.measureService.listAll(query);
  }

  @Post()
  async create(@Body() data: CreateMeasureBody) {
    const measure = new MeasureDomain(data);
    return this.measureService.createMeasure(measure);
  }
}
