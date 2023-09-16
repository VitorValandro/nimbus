import { Injectable } from '@nestjs/common';
import { MeasureRepository } from '../persistence/measure.repository';
import { MeasureDomain } from '../domain/measure';

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

  async createMeasure(data: MeasureDomain): Promise<MeasureDomain> {
    const measureModel = await this.repository.createMeasure(data);
    return new MeasureDomain(measureModel);
  }
}
