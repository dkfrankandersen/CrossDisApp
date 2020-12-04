import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pandora_app/models/step_data.dart';
import 'package:pandora_app/controllers/globals.dart' as globals;
import 'package:pandora_app/pages/label_event.dart';

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
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.hasDatumSelection) {
            DateTime selectedBarDateTime =
                model.selectedSeries[0].domainFn(model.selectedDatum[0].index);
            int selectedBarValue =
                model.selectedSeries[0].measureFn(model.selectedDatum[0].index);
            print(selectedBarDateTime.toString());
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new LabelEventPage(
                        selectedBarDateTime, selectedBarValue)));
          }
        })
      ],
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
