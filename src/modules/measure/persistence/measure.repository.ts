import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../infrastructure/prisma.service';
import { Measure, Prisma } from '@prisma/client';
import { DateDomain } from 'src/modules/shared/domain/date';

@Injectable()
export class MeasureRepository {
  constructor(private prisma: PrismaService) {}

  async measure(
    measureWhereUniqueInput: Prisma.MeasureWhereUniqueInput,
  ): Promise<Measure | null> {
    return this.prisma.measure.findUnique({
      where: measureWhereUniqueInput,
    });
  }

  async measures(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.MeasureWhereUniqueInput;
    where?: Prisma.MeasureWhereInput;
    orderBy?: Prisma.MeasureOrderByWithRelationInput;
  }): Promise<Measure[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.measure.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  async measureFromPastThreeHours(
    referenceDate: Date,
  ): Promise<Measure | null> {
    const dateRangeStart = DateDomain.addHoursToDate(referenceDate, -6);
    const dateRangeEnd = DateDomain.addHoursToDate(referenceDate, -3);

    return this.prisma.measure.findFirst({
      where: {
        timestamp: {
          gte: dateRangeStart,
          lte: dateRangeEnd,
        },
      },
      orderBy: {
        timestamp: 'desc',
      },
    });
  }

  async createMeasure(data: Prisma.MeasureCreateInput): Promise<Measure> {
    return this.prisma.measure.create({
      data,
    });
  }

  async updateMeasure(params: {
    where: Prisma.MeasureWhereUniqueInput;
    data: Prisma.MeasureUpdateInput;
  }): Promise<Measure> {
    const { where, data } = params;
    return this.prisma.measure.update({
      data,
      where,
    });
  }

  async deleteMeasure(where: Prisma.MeasureWhereUniqueInput): Promise<Measure> {
    return this.prisma.measure.delete({
      where,
    });
  }
}
