import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../constants/color.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  TrackballBehavior? _trackballBehavior;

  Future<String> _loadSalesDataAsset() async {
    return rootBundle.loadString('assets/images/chart_data.json');
  }

  Future loadSalesData() async {
    final String jsonString = await _loadSalesDataAsset(); // Deserialization  step 1
    final dynamic jsonResponse = json.decode(jsonString); // Deserialization  step 2
    setState(() {
      // ignore: always_specify_types
      for (final Map<dynamic, dynamic> i in jsonResponse) {
        chartData!.add(_SampleData.fromJson(i)); // Deserialization step 3
      }
    });
  }

  @override
  void initState() {
    super.initState();
    chartData = <_SampleData>[];
    loadSalesData();
    _trackballBehavior = TrackballBehavior(
        enable: true,
        lineColor: AppColors.Green,
        lineWidth: 2,
        activationMode: ActivationMode.singleTap,
        markerSettings: const TrackballMarkerSettings(
            borderWidth: 4, height: 10, width: 10, markerVisibility: TrackballVisibilityMode.visible));
  }

  List<_SampleData>? chartData;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart( 
      zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
        key: GlobalKey(),
        plotAreaBorderWidth: 0,
        title: ChartTitle(text: 'Сенсор мэдээлэл'),
        legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
        primaryXAxis: DateTimeAxis(
          autoScrollingMode: AutoScrollingMode.end, intervalType: DateTimeIntervalType.months
          // enableAutoIntervalOnZooming: true,
          //     edgeLabelPlacement: EdgeLabelPlacement.shift,
          //     intervalType: DateTimeIntervalType.months,
          // dateFormat: DateFormat.m(),
          // majorGridLines: const MajorGridLines(width: 0),
          ),
        primaryYAxis: NumericAxis(
            rangePadding: ChartRangePadding.none,
            name: '...',
            minimum: 70,
            maximum: 110,
            interval: 10,
            axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
        series: _getDefaultLineSeries(),
      trackballBehavior: _trackballBehavior,
    );
  }

  List<LineSeries<_SampleData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<_SampleData, DateTime>>[
      LineSeries<_SampleData, DateTime>(
        dataSource: chartData!,
        xValueMapper: (_SampleData sales, _) => sales.x,
        yValueMapper: (_SampleData sales, _) => sales.y1,
        // name: 'Product A',
      ),
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
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
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Chart();
          },
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
