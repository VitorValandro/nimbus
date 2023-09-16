import { Module } from '@nestjs/common';
import { MeasureController } from './api/measure.controller';
import { MeasureRepository } from './persistence/measure.repository';
import { PrismaService } from '../../infrastructure/prisma.service';
import { MeasureService } from './service/measure.service';

@Module({
  imports: [],
  providers: [MeasureService, PrismaService, MeasureRepository],
  controllers: [MeasureController],
})
export class MeasureModule {}
