import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pandora_app/models/step_data.dart';

class StepDataBar extends StatelessWidget {
  final List<charts.Series<TimeSeriesSteps, DateTime>> seriesList;
  final bool animate;

  StepDataBar(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      // It is recommended that default interactions be turned off if using bar
      // renderer, because the line point highlighter is the default for time
      // series chart.
      defaultInteractions: false,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar charts.
      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSteps, DateTime>> createTimeSeries(
      List<StepData> stepDataLst) {
    List<TimeSeriesSteps> data = [];
    if (stepDataLst != null) {
      for (StepData sd in stepDataLst) {
        int steps = sd.steps;
        data.add(new TimeSeriesSteps(sd.datetime, steps));
      }
    }

    if (data.isEmpty) {
      DateTime now = DateTime.now();
      for (var i = 0; i < 24; i++) {
        DateTime dt = DateTime.parse(
            '${now.year}-${now.month}-${now.day} ${i.toString().padLeft(2, '0')}:00:00.000');
        data.add(new TimeSeriesSteps(dt, 0));
      }
    }

    return [
      new charts.Series<TimeSeriesSteps, DateTime>(
        id: 'Steps',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSteps step, _) => step.time,
        measureFn: (TimeSeriesSteps step, _) => step.steps,
        data: data,
      )
    ];
  }
}

class TimeSeriesSteps {
  final DateTime time;
  final int steps;

  TimeSeriesSteps(this.time, this.steps);
}
