import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/conf_global.dart';
import 'package:mvvm/constants/color.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Season {
  final int id;
  final String name;
  final String startDate;
  final String endDate;

  Season({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json['season_id'],
      name: json['season_name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Season> seasons = [];
  Season? selectedSeason;
  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    print('skjbhjbvkjjvbjhbdvhdhbsvh hjdfbv');
    print(Globals.prof_company_id);
    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        'http://103.143.40.250:8100/api/get/season/profcompany?prof_company_id=${Globals.prof_company_id}';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status']) {
      final seasonData = data['data'] as List<dynamic>;
      final seasons =
          seasonData.map((seasonJson) => Season.fromJson(seasonJson)).toList();
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
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.04,
      child: Center(
        child: DropdownButton(
          elevation: 10,
          borderRadius: BorderRadius.circular(12),
          // isExpanded: true,
          iconEnabledColor: Colors.white,
          dropdownColor: Color.fromARGB(255, 21, 142, 128),
          hint: Text(
            'Улирал сонгох',
            style: TextStyle(color: Colors.white),
          ),
          value: selectedSeason,
          onChanged: (Season? season) {
            setState(() {
              selectedSeason = season;
            });
          },
          items: seasons
              .map((season) => DropdownMenuItem(
                    value: season,
                    child: Column(
                      children: [
                        Text(
                          season.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        Row(
                          children: [
                            Text(
                              season.startDate,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              ' - ${season.endDate}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
