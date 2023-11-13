import 'dart:ui';

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

  String get animation {
    switch (this) {
      case ZambrettiEnum.fallingSettledFine:
      case ZambrettiEnum.steadySettledFine:
      case ZambrettiEnum.risingSettledFine:
      case ZambrettiEnum.fallingFineWeather:
      case ZambrettiEnum.steadyFineWeather:
      case ZambrettiEnum.risingFineWeather:
        return 'assets/sunny.json';

      case ZambrettiEnum.fineBecomingLessSettled:
      case ZambrettiEnum.fairlyFineShoweryLater:
      case ZambrettiEnum.finePossiblyShowers:
      case ZambrettiEnum.fairlyFinePossiblyShowersEarly:
      case ZambrettiEnum.fairlyFineImproving:
      case ZambrettiEnum.becomingFine:
        return 'assets/partially_cloudy.json';

      case ZambrettiEnum.showeryBecomingMoreUnsettled:
      case ZambrettiEnum.showeryBrightIntervals:
      case ZambrettiEnum.showeryEarlyImproving:
        return 'assets/cloudy_rain.json';

      // Chuvoso
      case ZambrettiEnum.unsettledRainLater:
      case ZambrettiEnum.rainAtTimesWorseLater:
      case ZambrettiEnum.rainAtTimesBecomingVeryUnsettled:
      case ZambrettiEnum.rainAtFrequentIntervals:
      case ZambrettiEnum.steadyVeryUnsettledRain:
      case ZambrettiEnum.unsettledRainAtTimes:
      // Tempestade
      case ZambrettiEnum.fallingVeryUnsettledRain:
      case ZambrettiEnum.unsettledProbablyImproving:
      case ZambrettiEnum.unsettledShortFineIntervals:
      case ZambrettiEnum.veryUnsettledFinerAtTimes:
      case ZambrettiEnum.stormyPossiblyImproving:
      case ZambrettiEnum.steadyStormyMuchRain:
      case ZambrettiEnum.risingStormyMuchRain:
        return 'assets/storm.json';

      case ZambrettiEnum.fairlyFineShowersLikely:
      case ZambrettiEnum.changeableSomeRain:
      case ZambrettiEnum.changeableMending:
      case ZambrettiEnum.ratherUnsettledClearingLater:
        return 'assets/cloudy.json';
    }
  }

  String get title {
    switch (this) {
      case ZambrettiEnum.fallingSettledFine:
      case ZambrettiEnum.steadySettledFine:
      case ZambrettiEnum.risingSettledFine:
      case ZambrettiEnum.fallingFineWeather:
      case ZambrettiEnum.steadyFineWeather:
      case ZambrettiEnum.risingFineWeather:
        return 'Ensolarado';

      case ZambrettiEnum.fineBecomingLessSettled:
      case ZambrettiEnum.fairlyFineShoweryLater:
      case ZambrettiEnum.finePossiblyShowers:
      case ZambrettiEnum.fairlyFinePossiblyShowersEarly:
      case ZambrettiEnum.fairlyFineImproving:
      case ZambrettiEnum.becomingFine:
        return 'Parcialmente Nublado';

      case ZambrettiEnum.showeryBecomingMoreUnsettled:
      case ZambrettiEnum.showeryBrightIntervals:
      case ZambrettiEnum.showeryEarlyImproving:
        return 'Sol e Chuva';

      case ZambrettiEnum.unsettledRainLater:
      case ZambrettiEnum.rainAtTimesWorseLater:
      case ZambrettiEnum.rainAtTimesBecomingVeryUnsettled:
      case ZambrettiEnum.rainAtFrequentIntervals:
      case ZambrettiEnum.steadyVeryUnsettledRain:
      case ZambrettiEnum.unsettledRainAtTimes:
        return 'Chuvoso';

      case ZambrettiEnum.fallingVeryUnsettledRain:
      case ZambrettiEnum.unsettledProbablyImproving:
      case ZambrettiEnum.unsettledShortFineIntervals:
      case ZambrettiEnum.veryUnsettledFinerAtTimes:
      case ZambrettiEnum.stormyPossiblyImproving:
      case ZambrettiEnum.steadyStormyMuchRain:
      case ZambrettiEnum.risingStormyMuchRain:
        return 'Tempestade';

      case ZambrettiEnum.fairlyFineShowersLikely:
      case ZambrettiEnum.changeableSomeRain:
      case ZambrettiEnum.changeableMending:
      case ZambrettiEnum.ratherUnsettledClearingLater:
        return 'Nublado';
    }
  }

  String get description {
    switch (this) {
      case ZambrettiEnum.fallingSettledFine:
      case ZambrettiEnum.steadySettledFine:
      case ZambrettiEnum.risingSettledFine:
        return 'Estável, tempo bom';
      case ZambrettiEnum.steadyFineWeather:
      case ZambrettiEnum.fallingFineWeather:
      case ZambrettiEnum.risingFineWeather:
        return 'Tempo bom';
      case ZambrettiEnum.fineBecomingLessSettled:
        return 'Bom, tendendo a menos estável';
      case ZambrettiEnum.fairlyFineShoweryLater:
        return 'Razoavelmente bom, possíveis chuvas mais tarde';
      case ZambrettiEnum.showeryBecomingMoreUnsettled:
        return 'Chuvoso, tendendo a mais instável';
      case ZambrettiEnum.unsettledRainLater:
        return 'Instável, chuva mais tarde';
      case ZambrettiEnum.rainAtTimesWorseLater:
        return 'Chuva dispersa, pior mais tarde';
      case ZambrettiEnum.rainAtTimesBecomingVeryUnsettled:
        return 'Chuva dispersa, tendendo a muito instável';
      case ZambrettiEnum.fallingVeryUnsettledRain:
        return 'Muito instável, chuva';
      case ZambrettiEnum.finePossiblyShowers:
        return 'Tempo bom, possíveis chuvas';
      case ZambrettiEnum.fairlyFineShowersLikely:
        return 'Razoavelmente bom, chuvas prováveis';
      case ZambrettiEnum.showeryBrightIntervals:
        return 'Chuvoso, intervalos claros';
      case ZambrettiEnum.changeableSomeRain:
        return 'Mudanças, alguma chuva';
      case ZambrettiEnum.unsettledRainAtTimes:
        return 'Instável, chuva por vezes';
      case ZambrettiEnum.rainAtFrequentIntervals:
        return 'Chuva em intervalos frequentes';
      case ZambrettiEnum.steadyVeryUnsettledRain:
        return 'Muito instável, chuva';
      case ZambrettiEnum.steadyStormyMuchRain:
        return 'Tempestuoso, muita chuva';
      case ZambrettiEnum.becomingFine:
        return 'Tempo melhorando';
      case ZambrettiEnum.fairlyFineImproving:
        return 'Razoavelmente bom, melhorando';
      case ZambrettiEnum.fairlyFinePossiblyShowersEarly:
        return 'Razoavelmente bom, possíveis chuvas de manhã';
      case ZambrettiEnum.showeryEarlyImproving:
        return 'Chuvoso, manhã melhorando';
      case ZambrettiEnum.changeableMending:
        return 'Mudanças, melhorando';
      case ZambrettiEnum.ratherUnsettledClearingLater:
        return 'Um pouco instável, melhorando mais tarde';
      case ZambrettiEnum.unsettledProbablyImproving:
        return 'Instável, provavelmente melhorando';
      case ZambrettiEnum.unsettledShortFineIntervals:
        return 'Instável, breves intervalos bons';
      case ZambrettiEnum.veryUnsettledFinerAtTimes:
        return 'Muito instável, bons momentos';
      case ZambrettiEnum.stormyPossiblyImproving:
        return 'Tempestuoso, possível melhora';
      case ZambrettiEnum.risingStormyMuchRain:
        return 'Subindo, tempestuoso, muita chuva';
    }
  }

  Color get gradientColor {
    switch (this) {
      // Sol e chuva
      case ZambrettiEnum.showeryBecomingMoreUnsettled:
      case ZambrettiEnum.showeryBrightIntervals:
      case ZambrettiEnum.showeryEarlyImproving:
      // Parcialmente nublado
      case ZambrettiEnum.fineBecomingLessSettled:
      case ZambrettiEnum.fairlyFineShoweryLater:
      case ZambrettiEnum.finePossiblyShowers:
      case ZambrettiEnum.fairlyFinePossiblyShowersEarly:
      case ZambrettiEnum.fairlyFineImproving:
      case ZambrettiEnum.becomingFine:
      // Ensolarado
      case ZambrettiEnum.fallingSettledFine:
      case ZambrettiEnum.steadySettledFine:
      case ZambrettiEnum.risingSettledFine:
      case ZambrettiEnum.fallingFineWeather:
      case ZambrettiEnum.steadyFineWeather:
      case ZambrettiEnum.risingFineWeather:
        return const Color.fromARGB(255, 244, 235, 195);

      // Chuvoso
      case ZambrettiEnum.unsettledRainLater:
      case ZambrettiEnum.rainAtTimesWorseLater:
      case ZambrettiEnum.rainAtTimesBecomingVeryUnsettled:
      case ZambrettiEnum.rainAtFrequentIntervals:
      case ZambrettiEnum.steadyVeryUnsettledRain:
      case ZambrettiEnum.unsettledRainAtTimes:
      // Nublado
      case ZambrettiEnum.fairlyFineShowersLikely:
      case ZambrettiEnum.changeableSomeRain:
      case ZambrettiEnum.changeableMending:
      case ZambrettiEnum.ratherUnsettledClearingLater:
      // Tempestade
      case ZambrettiEnum.fallingVeryUnsettledRain:
      case ZambrettiEnum.unsettledProbablyImproving:
      case ZambrettiEnum.unsettledShortFineIntervals:
      case ZambrettiEnum.veryUnsettledFinerAtTimes:
      case ZambrettiEnum.stormyPossiblyImproving:
      case ZambrettiEnum.steadyStormyMuchRain:
      case ZambrettiEnum.risingStormyMuchRain:
      default:
        return const Color.fromARGB(131, 184, 184, 189);
    }
  }
}
