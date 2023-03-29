import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/screen/profile%20screen/profile_screen.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class Crop extends StatefulWidget {
  @override
  State<Crop> createState() => _CropState();
}

class _CropState extends State<Crop> {
  var data = [];
  List<CropModel> results = [];

  late List<Employee> _employees;
  late EmployeeDataSource _employeeDataSource;
  // Future<List<CropModel>> getCrop() async {
  //   var url = Uri.parse('http://103.143.40.250:8100/api/get/season/crop/list');
  //   try {
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       data = json.decode(response.body);
  //       results = data.map((e) => CropModel.fromJson(e)).toList();
  //       print(response.body);
  //     } else {
  //       print("fetch error");
  //     }
  //   } on Exception catch (e) {
  //     print('error: $e');
  //   }
  //   return results;
  // }

  @override
  void initState() {
    // getCrop();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'crop rotation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.Green,
      ),
      body: SfDataGridTheme(
        data: SfDataGridThemeData(
          selectionColor: Colors.transparent,
          frozenPaneElevation: 0,
          headerColor: Color.fromARGB(255, 201, 230, 227),
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
            showMaterialModalBottomSheet(
              backgroundColor: AppColors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              duration: Duration(milliseconds: 500),
              enableDrag: true,
              bounce: false,
              // expand: true,
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  // controller: ModalScrollController.of(context),
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Colors.green,

                        ),
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 4.5,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ],
                          ),
                        ),
                        Line2(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                          color: Colors.white,
                          child: Column(
                            children: [
                              CropButton(
                                title: 'Crop',
                                cropName: _employeeDataSource.effectiveRows[
                                        details.rowColumnIndex.rowIndex - 1]
                                    .getCells()[
                                        details.rowColumnIndex.columnIndex]
                                    .value
                                    .toString(),
                              ),
                              CropButton(
                                title: 'Crop',
                                cropName: _employeeDataSource.effectiveRows[
                                        details.rowColumnIndex.rowIndex - 1]
                                    .getCells()[
                                        details.rowColumnIndex.columnIndex]
                                    .value
                                    .toString(),
                              ),
                              CropButton(
                                title: 'Crop',
                                cropName: _employeeDataSource.effectiveRows[
                                        details.rowColumnIndex.rowIndex - 1]
                                    .getCells()[
                                        details.rowColumnIndex.columnIndex]
                                    .value
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          columns: [
            GridColumn(
              columnName: 'Name',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    '',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            GridColumn(
              columnName: 'Арвин хур 2023',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Center(
                  child: Text(
                    'Арвин хур 2023',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            GridColumn(
              columnName: 'Арвин хур 2023',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    'Арвин хур 2023',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
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
              ),
            ),
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
              ),
            ),
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
              ),
            ),
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
              ),
            ),
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
              ),
            ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  late List<DataGridRow> dataGridRows;
  EmployeeDataSource(List<Employee> employees) {
    dataGridRows = employees
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'name',
                value: dataGridRow.name,
              ),
              DataGridCell<String>(
                columnName: 'Арвин хур 2023',
                value: dataGridRow.id,
              ),
              DataGridCell<String>(
                columnName: 'Арвин хур 2023',
                value: dataGridRow.designation,
              ),
              DataGridCell<String>(
                columnName: 'salary',
                value: dataGridRow.salary,
              ),
              DataGridCell<String>(
                columnName: 'test1',
                value: dataGridRow.test1,
              ),
              DataGridCell<String>(
                columnName: 'test2',
                value: dataGridRow.test2,
              ),
              DataGridCell<String>(
                columnName: 'test3',
                value: dataGridRow.test3,
              ),
              DataGridCell<String>(
                columnName: 'test4',
                value: dataGridRow.test4,
              ),
              DataGridCell<String>(
                columnName: 'test5',
                value: dataGridRow.test5,
              ),
            ],
          ),
        )
        .toList();
  }
  @override
  List<DataGridRow> get rows => dataGridRows;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      // color: Color.fromARGB(255, 233, 131, 124),
      cells: row.getCells().map<Widget>((dataGridCell) {
        Color getColor() {
          if (dataGridCell.columnName == 'Арвин хур 2023') {
            if (dataGridCell.value == 'Wheat soft, spring') {
              return Color.fromARGB(255, 244, 147, 147);
            } else if (dataGridCell.value == 'Mustard, black') {
              return Color.fromARGB(255, 245, 235, 205);
            }
          }

          return Colors.transparent;
        }

        return Container(
            color: getColor(),
            child: Center(
                child: Text(
              dataGridCell.value.toString(),
              style: TextStyle(fontSize: 12),
            )));
      }).toList(),
    );
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary, this.test1,
      this.test2, this.test3, this.test4, this.test5);

  final String id;
  final String name;
  final String designation;
  final String salary;
  final String test1;
  final String test2;
  final String test3;
  final String test4;
  final String test5;
}
// api/get/season/crop/list

class CropModel {
  String? rowId;
  String? columnId;
  String? parcelId;
  String? seasonId;
  String? name;
  String? addressStreetname;
  String? seasonName;
  String? startDate;
  String? endDate;
  String? planHa;
  String? harvestHa;
  String? personId;

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

List<Employee> getEmployeeData() {
  return [
    Employee('+', 'James', '+', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Kathryn', 'Mustard, black', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Lara', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Michael', '+', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Martin', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Newberry', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Balnc', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Perry', '+', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Gable', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Grimes', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'James', '+', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Kathryn', 'Mustard, black', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Lara', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Michael', '+', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Martin', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Newberry', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Balnc', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Perry', '+', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Gable', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Grimes', 'Sr.Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'James', '+', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Kathryn', 'Mustard, black', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Lara', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Michael', '+', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Martin', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Newberry', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Balnc', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Perry', '+', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Gable', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Grimes', 'Sr.Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'James', '+', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Kathryn', 'Mustard, black', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Lara', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Michael', '+', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Martin', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Newberry', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Balnc', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Perry', '+', '+', '+', '+', '+', '+', '+'),
    Employee('+', 'Gable', 'Wheat soft,\ spring', '+', '+', '+', '+', '+', '+'),
    Employee(
        '+', 'Grimes', 'Sr.Wheat soft,\ spring', '+', '+', '+', '+', '+', '+')
  ];
}

class CropButton extends StatelessWidget {
  final String title;
  final String cropName;
  const CropButton({
    Key? key,
    required this.title,
    required this.cropName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.065,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(title),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Text(
                        cropName,
                        style: TextStyle(color: AppColors.Green),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Line(),
      ],
    );
  }
}
