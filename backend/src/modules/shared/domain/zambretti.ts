export enum ZambrettiEnum {
  FALLING_SETTLED_FINE = 1,
  FALLING_FINE_WEATHER = 2,
  FINE_BECOMING_LESS_SETTLED = 3,
  FAIRLY_FINE_SHOWERY_LATER = 4,
  SHOWERY_BECOMING_MORE_UNSETTLED = 5,
  UNSETTLED_RAIN_LATER = 6,
  RAIN_AT_TIMES_WORSE_LATER = 7,
  RAIN_AT_TIMES_BECOMING_VERY_UNSETTLED = 8,
  FALLING_VERY_UNSETTLED_RAIN = 9,
  STEADY_SETTLED_FINE = 10,
  STEADY_FINE_WEATHER = 11,
  FINE_POSSIBLY_SHOWERS = 12,
  FAIRLY_FINE_SHOWERS_LIKELY = 13,
  SHOWERY_BRIGHT_INTERVALS = 14,
  CHANGEABLE_SOME_RAIN = 15,
  UNSETTLED_RAIN_AT_TIMES = 16,
  RAIN_AT_FREQUENT_INTERVALS = 17,
  STEADY_VERY_UNSETTLED_RAIN = 18,
  STEADY_STORMY_MUCH_RAIN = 19,
  RISING_SETTLED_FINE = 20,
  RISING_FINE_WEATHER = 21,
  BECOMING_FINE = 22,
  FAIRLY_FINE_IMPROVING = 23,
  FAIRLY_FINE_POSSIBLY_SHOWERS_EARLY = 24,
  SHOWERY_EARLY_IMPROVING = 25,
  CHANGEABLE_MENDING = 26,
  RATHER_UNSETTLED_CLEARING_LATER = 27,
  UNSETTLED_PROBABLY_IMPROVING = 28,
  UNSETTLED_SHORT_FINE_INTERVALS = 29,
  VERY_UNSETTLED_FINER_AT_TIMES = 30,
  STORMY_POSSIBLY_IMPROVING = 31,
  RISING_STORMY_MUCH_RAIN = 32,
}

enum PressureTrendsEnum {
  FALLING,
  STEADY,
  RISING,
}
const SIGNIFICANT_PRESSURE_CHANGE = 1.6;

export class Zambretti {
  constructor() {}

  private static hasPressureDropped = (current: number, last: number) => {
    return current + SIGNIFICANT_PRESSURE_CHANGE <= last;
  };

  private static hasPressureRaised = (current: number, last: number) => {
    return current >= last + SIGNIFICANT_PRESSURE_CHANGE;
  };

  private static getPressureTrends = (
    currentPressureMeasure: number,
    pastThreeHourPressureMeasure: number = 1015,
  ) => {
    if (
      currentPressureMeasure >= 985 &&
      currentPressureMeasure <= 1050 &&
      Zambretti.hasPressureDropped(
        currentPressureMeasure,
        pastThreeHourPressureMeasure,
      )
    ) {
      return PressureTrendsEnum.FALLING;
    }

    if (
      currentPressureMeasure >= 960 &&
      currentPressureMeasure <= 1033 &&
      !Zambretti.hasPressureDropped(
        currentPressureMeasure,
        pastThreeHourPressureMeasure,
      ) &&
      !Zambretti.hasPressureRaised(
        currentPressureMeasure,
        pastThreeHourPressureMeasure,
      )
    ) {
      return PressureTrendsEnum.STEADY;
    }

    if (
      currentPressureMeasure >= 947 &&
      currentPressureMeasure <= 1030 &&
      Zambretti.hasPressureRaised(
        currentPressureMeasure,
        pastThreeHourPressureMeasure,
      )
    ) {
      return PressureTrendsEnum.RISING;
    }

    throw new Error(
      `Wasn't possible to determine the pressure trend for p=${currentPressureMeasure}`,
    );
  };

  private static calculateZambrettiConstant = (
    currentPressureMeasure: number,
    pressureTrend: PressureTrendsEnum,
  ): number => {
    switch (pressureTrend) {
      case PressureTrendsEnum.FALLING:
        return 127 - 0.12 * currentPressureMeasure;
      case PressureTrendsEnum.STEADY:
        return 144 - 0.13 * currentPressureMeasure;
      case PressureTrendsEnum.RISING:
        return 185 - 0.16 * currentPressureMeasure;
      default:
        throw Error(
          `Wasn't possible to calculate the zambretti value for pressure trend '${pressureTrend}'`,
        );
    }
  };

  static calculateZambretti = (
    currentPressureMeasure: number,
    pastThreeHourPressureMeasure?: number,
  ): ZambrettiEnum => {
    const pressureTrend = this.getPressureTrends(
      currentPressureMeasure,
      pastThreeHourPressureMeasure,
    );

    const zambrettiConstant = Math.round(
      this.calculateZambrettiConstant(currentPressureMeasure, pressureTrend),
    );

    return zambrettiConstant;
  };
}
