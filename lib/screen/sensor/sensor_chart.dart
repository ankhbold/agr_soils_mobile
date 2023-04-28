import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../constants/color.dart';
import '../../models/sensor_data.dart';
import '../../services/sensor.dart';
import '../../widget/loader.dart';

class Chart extends StatefulWidget {
  Chart({
    super.key,
    this.sensorDatas,
    this.isAirtemp = false,
    this.isAirMoisture = false,
    this.isRawAirPressure = false,
    this.isBattery = false,
    this.isLuminance = false,
    this.isTemp = false,
    this.isMoisture = false,
  });
  List<SensorData>? sensorDatas;
  bool? isAirtemp;
  bool? isAirMoisture;
  bool? isRawAirPressure;
  bool? isBattery;
  bool? isLuminance;
  bool? isTemp;
  bool? isMoisture;
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
        borderWidth: 4,
        height: 10,
        width: 10,
        markerVisibility: TrackballVisibilityMode.visible,
      ),
    );
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

  double getChartValue({SensorData? sensorData}) {
    if (widget.isAirtemp!) {
      return double.parse(double.parse(sensorData!.air_temp!).toStringAsFixed(2));
    } else if (widget.isAirMoisture!) {
      return double.parse(double.parse(sensorData!.air_moisture!).toStringAsFixed(2));
    } else if (widget.isRawAirPressure!) {
      return double.parse(double.parse(sensorData!.raw_air_pressure!).toStringAsFixed(2));
    } else if (widget.isBattery!) {
      return double.parse(double.parse(sensorData!.battery!).toStringAsFixed(2));
    } else if (widget.isLuminance!) {
      return double.parse(double.parse(sensorData!.luminance!).toStringAsFixed(2));
    } else if (widget.isTemp!) {
      return double.parse(double.parse(sensorData!.temp!).toStringAsFixed(2));
    }
    return double.parse(double.parse(sensorData!.moisture!).toStringAsFixed(2));
  }

  List<LineSeries<SensorData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<SensorData, DateTime>>[
      LineSeries<SensorData, DateTime>(
        dataSource: widget.sensorDatas!,
        xValueMapper: (SensorData sensorData, _) => DateTime.parse(sensorData.datetime!),
        yValueMapper: (SensorData sensorData, _) => getChartValue(
          sensorData: sensorData,
        ),
      ),
    ];
  }
}

class ChartPage extends StatefulWidget {
  ChartPage({super.key, this.sensorId});

  int? sensorId;
  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final DateRangePickerController _controller = DateRangePickerController();
  List<SensorData> sensorDatas = [];
  DateTime? start_date = DateTime.now(),
      end_date = DateTime.now().add(
        Duration(days: 1),
      );
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
                  PickerDateRange pickerDateRange = (value as PickerDateRange);
                  start_date = pickerDateRange.startDate;
                  end_date = pickerDateRange.endDate;
                  LoadingIndicator(context: context).showLoadingIndicator();
                  SensorService()
                      .getSensorData(
                    id: widget.sensorId,
                    start_date: start_date.toString(),
                    end_date: end_date.toString(),
                  )
                      .then((value) {
                    LoadingIndicator(context: context).hideLoadingIndicator();
                    sensorDatas = value;
                    setState(() {});
                  
                  }).catchError((onError) {
                    LoadingIndicator(context: context).hideLoadingIndicator();
                  });
                },
              ),
            ),
            sensorDatas.isNotEmpty
                ? Column(
                    children: [
                      getChart(
                        label: 'Агаарын температур',
                        isAirtemp: true,
                      ),
                      getChart(
                        label: 'Агаарын чийгшил',
                        isAirMoisture: true,
                      ),
                      getChart(
                        label: 'Агаарын даралт',
                        isRawAirPressure: true,
                      ),
                      getChart(
                        label: 'Төхөөрөмжийн цэнэг',
                        isBattery: true,
                      ),
                      getChart(
                        label: 'Гэрэлтүүлэг',
                        isLuminance: true,
                      ),
                      getChart(
                        label: 'Хөрсний температур',
                        isTemp: true,
                      ),
                      getChart(
                        label: 'Хөрсний чийг',
                        isMoisture: true,
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  getChart({
    String? label,
    bool? isAirtemp = false,
    bool? isAirMoisture = false,
    bool? isRawAirPressure = false,
    bool? isBattery = false,
    bool? isLuminance = false,
    bool? isTemp = false,
    bool? isMoisture = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label!,
          textAlign: TextAlign.start,
        ),
        Chart(
          sensorDatas: sensorDatas,
          isAirtemp: isAirtemp,
          isAirMoisture: isAirMoisture,
          isRawAirPressure: isRawAirPressure,
          isBattery: isBattery,
          isLuminance: isLuminance,
          isTemp: isTemp,
          isMoisture: isMoisture,
        )
      ],
    );
  }
}
