import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/models/season.dart';

import '../../conf_global.dart';

class SeasonChoicePage extends StatefulWidget {
  @override
  SeasonChoicePageState createState() => SeasonChoicePageState();
}

class SeasonChoicePageState extends State<SeasonChoicePage> {
  List<Season> seasons = [];
  Season? selectedSeason;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = 'http://103.143.40.250:8100/api/get/season/profcompany?prof_company_id=${Globals.prof_company_id}';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['status']) {
      final seasonData = data['data'] as List<dynamic>;
      final seasons = seasonData.map((seasonJson) => Season.fromJson(seasonJson)).toList();
      if (seasons.isNotEmpty) {
        Globals.seasonId = seasons.first.season_id;
      }
      setState(() {
        this.seasons = seasons;
        selectedSeason = seasons.isNotEmpty ? seasons[0] : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.height * 0.04,
      child: Center(
        child: DropdownButton(
          underline: Container(
            height: 0,
            color: Colors.transparent,
          ),
          elevation: 10,
          borderRadius: BorderRadius.circular(12),
          iconEnabledColor: Colors.white,
          dropdownColor: Color.fromARGB(255, 21, 142, 128),
          hint: Text(
            'Улирал сонгох',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          value: selectedSeason,
          onChanged: (Season? season) {
            Globals.seasonId = season!.season_id;
            setState(() {
              selectedSeason = season;
            });
          },
          items: seasons
              .map(
                (season) => DropdownMenuItem(
                  onTap: () {
                    Globals.seasonId = season.season_id;
                    setState(() {
                      selectedSeason = season;
                    });
                  },
                  value: season,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        season.season_name!,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        children: [
                          Text(
                            season.start_date!,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            ' - ${season.end_date}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
