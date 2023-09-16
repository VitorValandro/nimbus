import { Module } from '@nestjs/common';
import { MeasureModule } from './modules/measure/measure.module';

@Module({
  imports: [MeasureModule],
  providers: [],
})
export class AppModule {}
