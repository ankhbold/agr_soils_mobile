import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../conf_global.dart';
import '../../models/season.dart';
import '../../widget/outlined_btn.dart';

// ignore: must_be_immutable
class SeasonChoicePage extends StatefulWidget {
  SeasonChoicePage({this.done, this.changeSeason});
  @override
  SeasonChoicePageState createState() => SeasonChoicePageState();
  Function? done;
  Function? changeSeason;
}

class SeasonChoicePageState extends State<SeasonChoicePage> {
  List<Season> seasons = [];
  Season? selectedSeason;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchData();
      widget.done!();
    });
  }

  Future<void> fetchData() async {
    final url = 'http://103.143.40.250:8100/api/get/season/profcompany?prof_company_id=${Globals.prof_company_id}';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['status']) {
      final seasonData = data['data'] as List<dynamic>;
      final seasons = seasonData.map((seasonJson) => Season.fromJson(seasonJson)).toList();
      if (seasons.isNotEmpty && Globals.seasonId == null) {
        Globals.seasonId = seasons.first.season_id;
      }
      setState(() {
        this.seasons = seasons;
        selectedSeason = seasons.isNotEmpty
            ? Globals.seasonId == null
                ? seasons[0]
                : seasons.singleWhere((element) => element.season_id == Globals.seasonId)
            : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return selectedSeason != null
        ? InkWell(
            onTap: () {
              showBarModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.all(20),
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: ListView.builder(
                              itemCount: seasons.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context, seasons[index]);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              seasons[index].season_name!,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              seasons[index].start_date!.toString() + ' - ${seasons[index].end_date}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(fontWeight: FontWeight.w500, color: Colors.grey),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            print('olson');
                                          },
                                          icon: Icon(
                                            Icons.edit_note_outlined,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            child: CustomOutlinedBtn(
                              textColor: Colors.white,
                              color: Colors.green,
                              text: 'Улирал үүсгэх',
                              onTap: () {},
                            ),
                          )
                        ],
                      ),
                    );
                  }).then((value) {
                if (value != null) {
                  selectedSeason = value;
                  Globals.seasonId = selectedSeason!.season_id;
                  widget.changeSeason!();
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.52,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        selectedSeason!.season_name!,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            selectedSeason!.start_date!,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            ' - ${selectedSeason!.end_date}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
          )
        : Container();
  }
}
