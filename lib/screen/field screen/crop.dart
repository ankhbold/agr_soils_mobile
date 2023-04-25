import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/models/crop_model.dart';
import 'package:mvvm/services/crop.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/crop.dart';

class CropPage extends StatefulWidget {
  @override
  State<CropPage> createState() => CropPageState();
}

Set<String> columnNames = {};
Set<int> areaIds = {};

class CropPageState extends State<CropPage> {
  var data = [];

  List<Crop> crops = [];
  List<CropModel> preapareCrops = [];

  Set<int> seasonIds = {};
  List<GridColumn> gridColumns = [];

  late List<UnitAreaData> unitAreaDatas;
  CropDataSource? cropDataSource;
  List<UnitAreaData> areaDatas = [];

  @override
  void initState() {
    CropService.getAllCrop().then((value) {
      crops = value;
      columnNames.add(" ");
      crops.forEach((element) {
        seasonIds.add(element.season_id!);
        columnNames.add(element.season_name!);
      });

      areaIds.forEach((areaId) {
        seasonIds.forEach((id) {
          crops.where((element) => element.season_id == id && element.parcel_id == areaId).forEach((element) {
            areaDatas.add(
              UnitAreaData(
                parcel_id: element.parcel_id,
                field_name: element.field_name,
                parcel_area_ha: element.parcel_area_ha,
                parcel_area_m2: element.parcel_area_m2,
                season_name: element.season_name,
                cult_names: element.cult_names,
                fill_color: element.fill_color,
                parcel_harvest_ha: element.parcel_harvest_ha,
                parcel_end_date: element.parcel_end_date,
                address_streetname: element.address_streetname,
              ),
            );
          });
        });
      });

      columnNames.forEach((value) {
        gridColumns.add(
          GridColumn(
            columnName: value,
            label: Container(
              child: Center(
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      });
      unitAreaDatas = areaDatas;
      cropDataSource = CropDataSource(unitAreaDatas);
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ургац',
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
          currentCellStyle: DataGridCurrentCellStyle(borderWidth: 2, borderColor: AppColors.Green),
        ),
        child: cropDataSource != null
            ? SfDataGrid(
                navigationMode: GridNavigationMode.cell,
                selectionMode: SelectionMode.single,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                frozenColumnsCount: 1,
                source: cropDataSource!,
                onCellTap: (DataGridCellTapDetails details) {},
                columns: gridColumns,
              )
            : Container(),
      ),
    );
  }
}

class CropDataSource extends DataGridSource {
  List<DataGridRow>? dataGridRows = [];

  CropDataSource(List<UnitAreaData> areas) {
    dataGridRows = areas
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: columnNames.map((e) {
              return DataGridCell<String>(
                columnName: e,
                value: e == " " ? dataGridRow.field_name : dataGridRow.cult_names,
              );
            }).toList(),
          ),
        )
        .toList();
  }
  @override
  List<DataGridRow> get rows => dataGridRows!;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
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
            ),
          ),
        );
      }).toList(),
    );
  }
}

class UnitAreaData {
  UnitAreaData(
      {this.parcel_id,
      this.field_name,
      this.parcel_area_ha,
      this.parcel_area_m2,
      this.season_name,
      this.cult_names,
      this.fill_color,
      this.parcel_harvest_ha,
      this.parcel_end_date,
      this.address_streetname});

  int? parcel_id;
  String? field_name;
  String? parcel_area_m2;
  String? parcel_area_ha;
  String? season_name;
  String? cult_names;
  String? fill_color;
  String? parcel_harvest_ha;
  String? parcel_end_date;
  String? address_streetname;
}
