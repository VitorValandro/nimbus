enum ZambrettiEnum {
  fallingSettledFine,
  fallingFineWeather,
  fineBecomingLessSettled,
  fairlyFineShoweryLater,
  showeryBecomingMoreUnsettled,
  unsettledRainLater,
  rainAtTimesWorseLater,
  rainAtTimesBecomingVeryUnsettled,
  fallingVeryUnsettledRain,
  steadySettledFine,
  steadyFineWeather,
  finePossiblyShowers,
  fairlyFineShowersLikely,
  showeryBrightIntervals,
  changeableSomeRain,
  unsettledRainAtTimes,
  rainAtFrequentIntervals,
  steadyVeryUnsettledRain,
  steadyStormyMuchRain,
  risingSettledFine,
  risingFineWeather,
  becomingFine,
  fairlyFineImproving,
  fairlyFinePossiblyShowersEarly,
  showeryEarlyImproving,
  changeableMending,
  ratherUnsettledClearingLater,
  unsettledProbablyImproving,
  unsettledShortFineIntervals,
  veryUnsettledFinerAtTimes,
  stormyPossiblyImproving,
  risingStormyMuchRain,
}

extension ZambrettiExtension on ZambrettiEnum {
  static ZambrettiEnum getZambrettiEnumFromInt(int value) {
    switch (value) {
      case 1:
        return ZambrettiEnum.fallingSettledFine;
      case 2:
        return ZambrettiEnum.fallingFineWeather;
      case 3:
        return ZambrettiEnum.fineBecomingLessSettled;
      case 4:
        return ZambrettiEnum.fairlyFineShoweryLater;
      case 5:
        return ZambrettiEnum.showeryBecomingMoreUnsettled;
      case 6:
        return ZambrettiEnum.unsettledRainLater;
      case 7:
        return ZambrettiEnum.rainAtTimesWorseLater;
      case 8:
        return ZambrettiEnum.rainAtTimesBecomingVeryUnsettled;
      case 9:
        return ZambrettiEnum.fallingVeryUnsettledRain;
      case 10:
        return ZambrettiEnum.steadySettledFine;
      case 11:
        return ZambrettiEnum.steadyFineWeather;
      case 12:
        return ZambrettiEnum.finePossiblyShowers;
      case 13:
        return ZambrettiEnum.fairlyFineShowersLikely;
      case 14:
        return ZambrettiEnum.showeryBrightIntervals;
      case 15:
        return ZambrettiEnum.changeableSomeRain;
      case 16:
        return ZambrettiEnum.unsettledRainAtTimes;
      case 17:
        return ZambrettiEnum.rainAtFrequentIntervals;
      case 18:
        return ZambrettiEnum.steadyVeryUnsettledRain;
      case 19:
        return ZambrettiEnum.steadyStormyMuchRain;
      case 20:
        return ZambrettiEnum.risingSettledFine;
      case 21:
        return ZambrettiEnum.risingFineWeather;
      case 22:
        return ZambrettiEnum.becomingFine;
      case 23:
        return ZambrettiEnum.fairlyFineImproving;
      case 24:
        return ZambrettiEnum.fairlyFinePossiblyShowersEarly;
      case 25:
        return ZambrettiEnum.showeryEarlyImproving;
      case 26:
        return ZambrettiEnum.changeableMending;
      case 27:
        return ZambrettiEnum.ratherUnsettledClearingLater;
      case 28:
        return ZambrettiEnum.unsettledProbablyImproving;
      case 29:
        return ZambrettiEnum.unsettledShortFineIntervals;
      case 30:
        return ZambrettiEnum.veryUnsettledFinerAtTimes;
      case 31:
        return ZambrettiEnum.stormyPossiblyImproving;
      case 32:
        return ZambrettiEnum.risingStormyMuchRain;
      default:
        throw Exception("Invalid integer value: $value");
    }
  }
}
