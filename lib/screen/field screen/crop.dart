import 'package:flutter/material.dart';
import 'package:mvvm/constants/colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Crop extends StatefulWidget {
  @override
  State<Crop> createState() => _CropState();
}

class _CropState extends State<Crop> {
  late List<Employee> _employees;
  late EmployeeDataSource _employeeDataSource;

  @override
  void initState() {
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: SfDataGrid(
        navigationMode: GridNavigationMode.cell,
        selectionMode: SelectionMode.single,
        frozenColumnsCount: 1,
        source: _employeeDataSource,
        onCellTap: (DataGridCellTapDetails details) {
          print(details.rowColumnIndex.columnIndex);
          print(details.rowColumnIndex.rowIndex);
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'))
                    ],
                    content: Text(_employeeDataSource
                        .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                        .getCells()[details.rowColumnIndex.columnIndex]
                        .value
                        .toString()),
                    title: const Text('Tapped Content'),
                  ));
        },
        columns: [
          GridColumn(
              columnName: 'id',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'id',
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              columnName: 'name',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Name',
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              columnName: 'designation',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Designation',
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              columnName: 'salary',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Salary',
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              columnName: 'test1',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'test1',
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              columnName: 'test2',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'test2',
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              columnName: 'test3',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'test3',
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              columnName: 'test4',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'test4',
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          GridColumn(
              columnName: 'test5',
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'test5',
                  overflow: TextOverflow.ellipsis,
                ),
              )),
        ],
      ),
    ));
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
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
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
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        child: Text(dataGridCell.value.toString()),
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
