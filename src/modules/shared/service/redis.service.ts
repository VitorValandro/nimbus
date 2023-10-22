import { CACHE_MANAGER } from '@nestjs/cache-manager';
import { Inject, Injectable, Logger } from '@nestjs/common';
import { Cache } from 'cache-manager';
import { MeasureDomain } from '../../measure/domain/measure';

export const TODAY_MEASURES_CACHE_KEY = 'today';

@Injectable()
export class RedisService {
  private readonly logger = new Logger(RedisService.name);
  constructor(@Inject(CACHE_MANAGER) private cacheService: Cache) {}

  public async cleanCachedTodayMeasures() {
    return this.cacheService.del(TODAY_MEASURES_CACHE_KEY);
  }

  public async getCachedTodayMeasures(): Promise<MeasureDomain[]> {
    return this.cacheService.get<MeasureDomain[]>(TODAY_MEASURES_CACHE_KEY);
  }

  public async setCachedTodayMeasures(measures: MeasureDomain[]) {
    return this.cacheService.set(TODAY_MEASURES_CACHE_KEY, measures);
  }

  public async updateCachedTodayMeasures(measure: MeasureDomain) {
    this.logger.log(
      `Started updating cache for '${TODAY_MEASURES_CACHE_KEY}' key`,
    );
    const currentCachedMeasures = await this.getCachedTodayMeasures();
    if (!currentCachedMeasures?.length) {
      this.logger.log(`No cache entries found. The cache won't be updated.`);
      return;
    }
    this.logger.log(
      `Successfully retrieved ${currentCachedMeasures.length} measures from cache.`,
    );

    this.logger.log(
      `Inserting new measure with timestamp = ${measure.timestamp.toISOString()} directly into cache.`,
    );

    currentCachedMeasures.push(measure);
    currentCachedMeasures.sort(
      (a, b) =>
        new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime(),
    );

    await this.setCachedTodayMeasures(currentCachedMeasures);

    this.logger.log(`Finished updating cache`);
  }
}
