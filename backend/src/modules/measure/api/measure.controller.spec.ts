import { validate } from 'class-validator';
import { plainToInstance } from 'class-transformer';
import { Test, TestingModule } from '@nestjs/testing';
import { MeasureDomain } from '../domain/measure';
import { MeasureController } from './measure.controller';
import { MeasureService } from '../service/measure.service';
import { GetAllMeasuresQueryParams } from './getAllMeasuresQueryParams.dto';

const measures: MeasureDomain[] = [];

const mockMeasureService = {
  listAll: jest.fn(),
  createMeasure: jest.fn(),
};

describe('Testing MeasureController getAll method', () => {
  let controller: MeasureController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MeasureController],
      providers: [{ provide: MeasureService, useValue: mockMeasureService }],
    }).compile();

    controller = module.get<MeasureController>(MeasureController);
    mockMeasureService.listAll.mockImplementation(async () =>
      Promise.resolve(measures),
    );
  });

  afterEach(async () => {
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should get a list of measures with an empty query as input', async () => {
    const measureList = await controller.getAll({});
    expect(measureList).toEqual(measures);
    expect(mockMeasureService.listAll).toHaveBeenCalledTimes(1);
  });

  it('should properly validate the skip query param as an integer', async () => {
    const dto = plainToInstance(GetAllMeasuresQueryParams, {
      skip: 'invalid',
    });
    const errors = await validate(dto);
    expect(errors.length).not.toBe(0);
    expect(JSON.stringify(errors)).toContain(
      `The skip param must be an integer number`,
    );
  });

  it('should properly validate the skip query param as an positive integer', async () => {
    const dto = plainToInstance(GetAllMeasuresQueryParams, {
      skip: '-1',
    });
    const errors = await validate(dto);
    expect(errors.length).not.toBe(0);
    expect(JSON.stringify(errors)).toContain(
      `The skip param must be 0 or a positive integer`,
    );
  });

  it('should properly validate a valid skip query param', async () => {
    const dto = plainToInstance(GetAllMeasuresQueryParams, {
      skip: '0',
    });
    const errors = await validate(dto);
    expect(errors.length).toBe(0);
  });

  it('should properly validate the take query param as integer', async () => {
    const dto = plainToInstance(GetAllMeasuresQueryParams, {
      take: 'invalid',
    });
    const errors = await validate(dto);
    expect(errors.length).not.toBe(0);
    expect(JSON.stringify(errors)).toContain(
      `The take param must be an integer number`,
    );
  });

  it('should properly validate the take query param as an integer greater than 0', async () => {
    const dto = plainToInstance(GetAllMeasuresQueryParams, {
      take: '0',
    });
    const errors = await validate(dto);
    expect(errors.length).not.toBe(0);
    expect(JSON.stringify(errors)).toContain(
      `The take param must be greater than 0`,
    );
  });

  it('should properly validate a valid take query param', async () => {
    const dto = plainToInstance(GetAllMeasuresQueryParams, {
      take: '10',
    });
    const errors = await validate(dto);
    expect(errors.length).toBe(0);
  });
});
