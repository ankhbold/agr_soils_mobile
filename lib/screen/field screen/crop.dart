import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm/constants/color.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_core/theme.dart';

class Crop extends StatefulWidget {
  @override
  State<Crop> createState() => _CropState();
}

class _CropState extends State<Crop> {
  late List<Employee> _employees;
  late EmployeeDataSource _employeeDataSource;
  var data = [];
  List<CropModel> results = [];
  Future<List<CropModel>> getCrop() async {
    var url = Uri.parse('http://103.143.40.250:8100/api/get/season/crop/list');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => CropModel.fromJson(e)).toList();
        print(response.body);
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }

  @override
  void getCropApi() {}
  void initState() {
    getCrop();

    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SfDataGridTheme(
        data: SfDataGridThemeData(
          selectionColor: Colors.transparent,
          frozenPaneElevation: 0,
          headerColor: const Color(0xff009889),
          frozenPaneLineWidth: 0.5,
          currentCellStyle: DataGridCurrentCellStyle(
              borderWidth: 2, borderColor: AppColors.Green),
        ),
        child: SfDataGrid(
          navigationMode: GridNavigationMode.cell,
          selectionMode: SelectionMode.single,
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          // onCellTap: (DataGridCellTapDetails tapDetails) {
          //   if (tapDetails.rowColumnIndex.rowIndex != -1 &&
          //       tapDetails.rowColumnIndex.columnIndex != -1) {
          //     final cellStyle =
          //         tapDetails.rowContainer.cellStyle[tapDetails.column.columnName];
          //     cellStyle.color = Colors.blue;
          //   }
          // },
          frozenColumnsCount: 1,
          source: _employeeDataSource,
          onCellTap: (DataGridCellTapDetails details) {
            print(details.rowColumnIndex.columnIndex);
            print(details.rowColumnIndex.rowIndex);
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 250,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(_employeeDataSource.effectiveRows[
                                  details.rowColumnIndex.rowIndex - 1]
                              .getCells()[details.rowColumnIndex.columnIndex]
                              .value
                              .toString()),
                        ],
                      ),
                    ),
                  );
                });
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) => AlertDialog(
            //           actions: <Widget>[
            //             TextButton(
            //                 onPressed: () => Navigator.pop(context),
            //                 child: const Text('OK'))
            //           ],
            //           content: Text(_employeeDataSource
            //               .effectiveRows[details.rowColumnIndex.rowIndex - 1]
            //               .getCells()[details.rowColumnIndex.columnIndex]
            //               .value
            //               .toString()),
            //           title: const Text('Tapped Content'),
            //         ));
          },
          columns: [
            GridColumn(
                columnName: 'Name',
                label: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'Name',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
            GridColumn(
                columnName: 'id',
                label: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Center(
                    child: Text(
                      'id',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
            GridColumn(
                columnName: 'designation',
                label: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'Designation',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
            GridColumn(
                columnName: 'salary',
                label: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'Salary',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
            GridColumn(
                columnName: 'test1',
                label: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'test1',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
            GridColumn(
                columnName: 'test2',
                label: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'test2',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
            GridColumn(
                columnName: 'test3',
                label: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'test3',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
            GridColumn(
                columnName: 'test4',
                label: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'test4',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
            GridColumn(
                columnName: 'test5',
                label: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'test5',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(
          10001, 'James', 'Project Lead', 20000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10002, 'Kathryn', 'Manager', 30000, 2000, 3000, 4000, 5000, 6000),
      Employee(10003, 'Lara', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10004, 'Michael', 'Designer', 12000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10005, 'Martin', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10006, 'Newberry', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10007, 'Balnc', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10008, 'Perry', 'Tech.Writer', 10000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10009, 'Gable', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10010, 'Grimes', 'Sr.Developer', 18000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10001, 'James', 'Project Lead', 20000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10002, 'Kathryn', 'Manager', 30000, 2000, 3000, 4000, 5000, 6000),
      Employee(10003, 'Lara', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10004, 'Michael', 'Designer', 12000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10005, 'Martin', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10006, 'Newberry', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10007, 'Balnc', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10008, 'Perry', 'Tech.Writer', 10000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10009, 'Gable', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10010, 'Grimes', 'Sr.Developer', 18000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10001, 'James', 'Project Lead', 20000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10002, 'Kathryn', 'Manager', 30000, 2000, 3000, 4000, 5000, 6000),
      Employee(10003, 'Lara', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10004, 'Michael', 'Designer', 12000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10005, 'Martin', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10006, 'Newberry', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10007, 'Balnc', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10008, 'Perry', 'Tech.Writer', 10000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10009, 'Gable', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10010, 'Grimes', 'Sr.Developer', 18000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10001, 'James', 'Project Lead', 20000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10002, 'Kathryn', 'Manager', 30000, 2000, 3000, 4000, 5000, 6000),
      Employee(10003, 'Lara', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10004, 'Michael', 'Designer', 12000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10005, 'Martin', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10006, 'Newberry', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10007, 'Balnc', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10008, 'Perry', 'Tech.Writer', 10000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10009, 'Gable', 'Developer', 15000, 2000, 3000, 4000, 5000, 6000),
      Employee(
          10010, 'Grimes', 'Sr.Developer', 18000, 2000, 3000, 4000, 5000, 6000)
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  late List<DataGridRow> dataGridRows;
  EmployeeDataSource(List<Employee> employees) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(
                  columnName: 'salary', value: dataGridRow.salary),
              DataGridCell<int>(columnName: 'test1', value: dataGridRow.test1),
              DataGridCell<int>(columnName: 'test2', value: dataGridRow.test2),
              DataGridCell<int>(columnName: 'test3', value: dataGridRow.test3),
              DataGridCell<int>(columnName: 'test4', value: dataGridRow.test4),
              DataGridCell<int>(columnName: 'test5', value: dataGridRow.test5),
            ]))
        .toList();
  }
  @override
  List<DataGridRow> get rows => dataGridRows;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        // color: Color.fromARGB(255, 233, 131, 124),
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        child: Center(child: Text(dataGridCell.value.toString())),
      );
    }).toList());
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary, this.test1,
      this.test2, this.test3, this.test4, this.test5);

  final int id;
  final String name;
  final String designation;
  final int salary;
  final int test1;
  final int test2;
  final int test3;
  final int test4;
  final int test5;
}
// api/get/season/crop/list

class CropModel {
  int? rowId;
  int? columnId;
  int? parcelId;
  int? seasonId;
  String? name;
  String? addressStreetname;
  String? seasonName;
  String? startDate;
  String? endDate;
  String? planHa;
  String? harvestHa;
  int? personId;

  CropModel(
      {this.parcelId,
      this.seasonId,
      this.name,
      this.addressStreetname,
      this.seasonName,
      this.startDate,
      this.endDate,
      this.planHa,
      this.harvestHa,
      this.personId});

  CropModel.fromJson(Map<String, dynamic> json) {
    parcelId = json['parcel_id'];
    seasonId = json['season_id'];
    name = json['name'];
    addressStreetname = json['address_streetname'];
    seasonName = json['season_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    planHa = json['plan_ha'];
    harvestHa = json['harvest_ha'];
    personId = json['person_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parcel_id'] = this.parcelId;
    data['season_id'] = this.seasonId;
    data['name'] = this.name;
    data['address_streetname'] = this.addressStreetname;
    data['season_name'] = this.seasonName;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['plan_ha'] = this.planHa;
    data['harvest_ha'] = this.harvestHa;
    data['person_id'] = this.personId;
    return data;
  }
}

// class FetchCropList {
//   var data = [];
//   List<CropModel> results = [];
//   Future<List<CropModel>> getCrop() async {
//     var url = Uri.parse('http://103.143.40.250:8100/api/get/season/crop/list');
//     try {
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         data = json.decode(response.body);
//         results = data.map((e) => CropModel.fromJson(e)).toList();
//         print(response.body);
//       } else {
//         print("fetch error");
//       }
//     } on Exception catch (e) {
//       print('error: $e');
//     }
//     return results;
//   }
// }
