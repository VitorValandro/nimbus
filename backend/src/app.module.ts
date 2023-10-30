import { Inject, Logger, Module } from '@nestjs/common';
import { MeasureModule } from './modules/measure/measure.module';
import { CACHE_MANAGER, CacheModule } from '@nestjs/cache-manager';
import * as redisStore from 'cache-manager-redis-store';
import { ConfigModule } from '@nestjs/config';
import { ScheduleModule } from '@nestjs/schedule';

@Module({
  imports: [
    ConfigModule.forRoot(),
    MeasureModule,
    CacheModule.register({
      isGlobal: true,
      store: redisStore,
      host: process.env.REDIS_HOST,
      port: process.env.REDIS_PORT,
      username: process.env.REDIS_USERNAME,
      password: process.env.REDIS_PASSWORD,
      no_ready_check: true,
    }),
    ScheduleModule.forRoot(),
  ],
  providers: [],
})
export class AppModule {
  private readonly logger = new Logger(AppModule.name);
  constructor(@Inject(CACHE_MANAGER) cacheManager) {
    const client = cacheManager.store.getClient();

    client.on('error', (error) => {
      this.logger.error(`Unable to connect to redis store. Error: ${error}`);
    });
  }
}
