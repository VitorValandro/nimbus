import { Injectable } from '@nestjs/common';
import { MeasureRepository } from '../persistence/measure.repository';
import { MeasureDomain, MeasureProps } from '../domain/measure';
import { Zambretti } from '../../shared/domain/zambretti';

@Injectable()
export class MeasureService {
  constructor(private repository: MeasureRepository) {}

  async getById(id: string): Promise<MeasureDomain | null> {
    const measureModel = await this.repository.measure({
      id: id,
    });

    if (!measureModel) return null;
    return new MeasureDomain(measureModel);
  }

  async listAll(params: {
    skip?: number;
    take?: number;
  }): Promise<MeasureDomain[]> {
    const { skip, take } = params;
    const measures = await this.repository.measures({
      skip,
      take,
      orderBy: { timestamp: 'desc' },
    });

    return measures.map((measure) => new MeasureDomain(measure));
  }

  async createMeasure(data: MeasureProps): Promise<MeasureDomain> {
    const measure = new MeasureDomain(data);
    measure.timestamp = new Date();

    const currentPressureAtSeaLevel = measure.pressure;

    const lastMeasure = await this.repository.measureFromPastThreeHours(
      measure.timestamp,
    );

    const lastMeasuredPressureAtSeaLevel = lastMeasure
      ? new MeasureDomain(lastMeasure).pressure
      : null;

    measure.zambretti = Zambretti.calculateZambretti(
      currentPressureAtSeaLevel,
      lastMeasuredPressureAtSeaLevel,
    );

    const measureModel = await this.repository.createMeasure(
      measure.toObject(),
    );

    return new MeasureDomain(measureModel);
  }
}
