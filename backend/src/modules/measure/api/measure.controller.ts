import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import { MeasureService } from '../service/measure.service';
import { GetAllMeasuresQueryParams } from './getAllMeasuresQueryParams.dto';
import { CreateMeasureBody } from './createMeasureBody.dto';

@Controller('measure')
export class MeasureController {
  constructor(private readonly measureService: MeasureService) {}

  @Get()
  async getAll(@Query() query: GetAllMeasuresQueryParams) {
    return this.measureService.listAll(query);
  }

  @Get('/today')
  async getAllMeasurementsTakenToday() {
    return this.measureService.listAllTodayMeasurements();
  }

  @Post()
  async create(@Body() data: CreateMeasureBody) {
    return this.measureService.createMeasure(data);
  }
}
