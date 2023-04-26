import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/models/sensor_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../constants/color.dart';

class Chart extends StatefulWidget {
  Chart({super.key, this.sensorDatas});
  List<SensorData>? sensorDatas;
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  TrackballBehavior? _trackballBehavior;

  @override
  void initState() {
    super.initState();

    _trackballBehavior = TrackballBehavior(
        enable: true,
        lineColor: AppColors.Green,
        lineWidth: 2,
        activationMode: ActivationMode.singleTap,
        markerSettings: const TrackballMarkerSettings(
            borderWidth: 4, height: 10, width: 10, markerVisibility: TrackballVisibilityMode.visible));
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
      key: GlobalKey(),
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Сенсор мэдээлэл'),
      legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: DateTimeAxis(
        autoScrollingMode: AutoScrollingMode.start,
        intervalType: DateTimeIntervalType.days,
        enableAutoIntervalOnZooming: true,
        dateFormat: DateFormat.yMMMEd(),
        isVisible: true,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        builder: (data, point, series, pointIndex, seriesIndex) {
          print(data.runtimeType);
          return Container();
        },
      ),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.none,
        name: '...',
        minimum: 0,
        maximum: 200,
        interval: 10,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      series: _getDefaultLineSeries(),
      trackballBehavior: _trackballBehavior,
    );
  }

  List<LineSeries<SensorData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<SensorData, DateTime>>[
      LineSeries<SensorData, DateTime>(
        dataSource: widget.sensorDatas!,
        xValueMapper: (SensorData sensorData, _) => DateTime.parse(sensorData.datetime!),
        yValueMapper: (SensorData sensorData, _) => int.parse(sensorData.air_moisture!),
        // name: 'Product A',
      ),
    ];
  }
}

class ChartPage extends StatefulWidget {
  ChartPage({super.key, this.sensorDatas});
  List<SensorData>? sensorDatas;
  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final DateRangePickerController _controller = DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сенсор мэдээлэл'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.grad,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: SfDateRangePicker(
                controller: _controller,
                selectionMode: DateRangePickerSelectionMode.extendableRange,
                headerStyle: DateRangePickerHeaderStyle(textAlign: TextAlign.left),
                monthViewSettings: DateRangePickerMonthViewSettings(
                  enableSwipeSelection: true,
                  showTrailingAndLeadingDates: true,
                  showWeekNumber: true,
                ),
                showActionButtons: true,
                allowViewNavigation: true,
                cancelText: 'Цуцлах',
                confirmText: 'Сонгох',
                onCancel: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Selection Cancelled',
                    ),
                    duration: Duration(milliseconds: 200),
                  ));
                },
                onSubmit: (Object? value) {
                  print(value.toString());
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Selection Confirmed' + value.toString(),
                    ),
                    duration: Duration(milliseconds: 200),
                  ));
                },
              ),
            ),
            Chart(
              sensorDatas: widget.sensorDatas,
            ),
            // Chart(sensorDatas: widget.sensorDatas),
            // Chart(sensorDatas: widget.sensorDatas),
            // Chart(sensorDatas: widget.sensorDatas),
            // Chart(sensorDatas: widget.sensorDatas),
            // Chart(sensorDatas: widget.sensorDatas),
            // Chart(sensorDatas: widget.sensorDatas),
          ],
        ),
      ),
    );
  }
}

class _SampleData {
  _SampleData(this.x, this.y1, this.y2);
  factory _SampleData.fromJson(Map<dynamic, dynamic> parsedJson) {
    return _SampleData(
      DateTime.parse(parsedJson['x']),
      parsedJson['y1'],
      parsedJson['y2'],
    );
  }
  DateTime x;
  num y1;
  num y2;
}
