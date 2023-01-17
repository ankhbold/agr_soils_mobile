import 'package:flutter/material.dart';
import 'package:mvvm/screen/field%20screen/field_sheet_button.dart';
import 'package:mvvm/screen/field%20screen/round_sheet_button.dart';
import 'package:mvvm/screen/field%20screen/season_sheet_button.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: MediaQuery.of(context).size.height * 0.06,
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.035,
              ),
              const Season(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
              ),
              const FieldsSheet(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              const RoundSheetButton(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
            ],
          ),
          const SizedBox(
            height: 0,
          ),
        ],
      ),
    ],
  );
}
