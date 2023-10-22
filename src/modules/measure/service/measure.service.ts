import { Injectable, Logger } from '@nestjs/common';
import { MeasureRepository } from '../persistence/measure.repository';
import { MeasureDomain, MeasureProps } from '../domain/measure';
import { Zambretti } from '../../shared/domain/zambretti';
import {
  RedisService,
  TODAY_MEASURES_CACHE_KEY,
} from 'src/modules/shared/service/redis.service';
import { Cron, CronExpression } from '@nestjs/schedule';

@Injectable()
export class MeasureService {
  private readonly logger = new Logger(MeasureService.name);
  constructor(
    private repository: MeasureRepository,
    private redis: RedisService,
  ) {}
  @Cron(CronExpression.EVERY_DAY_AT_MIDNIGHT)
  resetTodayMeaasures() {
    this.logger.log('Started resetting cache for today measures');
    this.redis.cleanCachedTodayMeasures();
    this.logger.log('Finished resetting cache for today measures');
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

  async listAllTodayMeasurements(): Promise<MeasureDomain[]> {
    this.logger.log(
      `Started listing all measurements for today (${new Date().toLocaleDateString()})`,
    );

    const cachedData = await this.redis.getCachedTodayMeasures();
    if (cachedData) {
      this.logger.log(
        `Cache hit on '${TODAY_MEASURES_CACHE_KEY}' key. Retrieving results from cache.`,
      );
      return cachedData;
    }

    this.logger.log(
      `Cache miss on '${TODAY_MEASURES_CACHE_KEY}' key. Retrieving results from database`,
    );

    const result = await this.repository.measuresForAllDay(new Date());
    const measures = result.map((measure) => new MeasureDomain(measure));

    if (measures.length > 0) {
      this.logger.log(
        `Finished retrieving ${measures.length} results from database. Storing results on cache.`,
      );
      await this.redis.setCachedTodayMeasures(measures);
    }

    this.logger.log(`Finished listing all measurements`);
    return measures;
  }

  async createMeasure(data: MeasureProps): Promise<MeasureDomain> {
    this.logger.log(`Started inserting a new measure entry`);
    const measure = new MeasureDomain(data);
    measure.timestamp = new Date();

    const currentPressureAtSeaLevel = measure.pressure;

    this.logger.log(`Retrieving measure from past 6 to 3 hours`);
    const lastMeasure = await this.repository.measureFromPastThreeHours(
      measure.timestamp,
    );

    let lastMeasuredPressureAtSeaLevel;
    if (lastMeasure) {
      const parsedLastMeasure = new MeasureDomain(lastMeasure);
      this.logger.log(
        `Successfully found an entry from past 6 to 3 hours. Time of last entry: ${parsedLastMeasure.timestamp.toISOString()}`,
      );
      lastMeasuredPressureAtSeaLevel = parsedLastMeasure.pressure;
    } else {
      this.logger.log(
        `Could not find any entry from past 6 to 3 hours. Using default pressure value as reference.`,
      );
    }

    measure.zambretti = Zambretti.calculateZambretti(
      currentPressureAtSeaLevel,
      lastMeasuredPressureAtSeaLevel,
    );

    this.logger.log(
      `Successfully calculated Zambretti value for new entry. Z = ${measure.zambretti}`,
    );

    const measureModel = await this.repository.createMeasure(
      measure.toObject(),
    );
    this.logger.log(`Successfully saved new Zambretti value in the database.`);

    this.redis.updateCachedTodayMeasures(measure);

    this.logger.log(`Finished inserting a new measure entry.`);
    return new MeasureDomain(measureModel);
  }
}
