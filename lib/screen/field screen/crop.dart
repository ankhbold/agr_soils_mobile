import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/models/crop_model.dart';
import 'package:mvvm/models/parcel_season.dart';
import 'package:mvvm/services/crop.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/crop.dart';

class CropPage extends StatefulWidget {
  @override
  State<CropPage> createState() => CropPageState();
}

Set<String> columnNames = {};

class CropPageState extends State<CropPage> {
  var data = [];

  Crop? crop;
  List<CropModel> preapareCrops = [];

  Set<int> seasonIds = {};
  List<GridColumn> gridColumns = [];

  late List<UnitAreaData> unitAreaDatas;
  CropDataSource? cropDataSource;
  List<UnitAreaData> areaDatas = [];

  @override
  void initState() {
    CropService.getAllCrop().then((value) {
      crop = value;
      columnNames.add("Талбай");
      crop!.seasons!.forEach((element) {
        seasonIds.add(element.season_id!);
        columnNames.add(element.season_name!);
      });
      crop!.parcels!.forEach((element) {
        areaDatas.add(UnitAreaData(
          parcel_id: element.id,
          field_name: element.field_name,
          parcelSeason: element.parcel_season,
        ));
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
              List<ParcelSeason> parcelSeasons = dataGridRow.parcelSeason!;

              return DataGridCell<List<dynamic>>(
                columnName: e,
                value: [
                  parcelSeasons.singleWhere(
                    (element) => element.season_name!.toUpperCase() == e.toUpperCase(),
                    orElse: () => ParcelSeason(),
                  ),
                  dataGridRow.field_name!
                ],
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
        Color getColor({String? color}) {
          return HexColor(color!);
        }

        return Container(
          color: ((dataGridCell.value as List)[0] as ParcelSeason).cult_name != null
              ? getColor(color: ((dataGridCell.value as List)[0] as ParcelSeason).fill_color)
              : Colors.transparent,
          child: Center(
            child: Text(
              ((dataGridCell.value as List)[0] as ParcelSeason).cult_name ?? (dataGridCell.value as List)[1].toString(),
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
      this.season_id,
      this.fill_color,
      this.parcel_harvest_ha,
      this.parcel_end_date,
      this.address_streetname,
      this.parcelSeason});

  int? parcel_id;
  String? field_name;
  String? parcel_area_m2;
  String? parcel_area_ha;
  String? season_name;
  int? season_id;
  String? cult_names;
  String? fill_color;
  String? parcel_harvest_ha;
  String? parcel_end_date;
  String? address_streetname;
  List<ParcelSeason>? parcelSeason;
}
