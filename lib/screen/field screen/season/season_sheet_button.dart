import 'package:flutter/material.dart';
import 'package:mvvm/constants/colors.dart';
import 'package:mvvm/screen/field%20screen/season/season_api.dart';

class Season extends StatefulWidget {
  const Season({
    Key? key,
  }) : super(key: key);

  @override
  State<Season> createState() => _SeasonState();
}

class _SeasonState extends State<Season> {
  late List<dynamic> _seasons;

  var isloaded = false;

  void _getSeasons() async {
    RepositorySeason networkHelper = RepositorySeason(url: uri);
    var data = await networkHelper.getData();

    if (data != null) {
      setState(() {
        _seasons = data['data'];
      });
    }
  }

  getSeasonApi() async {
    setState(() {});
  }

  @override
  void initState() {
    _getSeasons();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      width: MediaQuery.of(context).size.width * 0.265,
      height: MediaQuery.of(context).size.height * 0.03,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        const Text(
                          'Улирал сонгох',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.cancel,
                              size: 35,
                              color: Color.fromARGB(255, 188, 188, 188),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 0.5,
                      color: const Color.fromARGB(115, 104, 104, 104),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SeasonsList(
                      seasons: _seasons,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Улирал нэмэх',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
          // print(repository.);
        },
        child: Ink(
          // heroTag: Text("btn1"),
          color: AppColors.Green.withOpacity(0.7),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                ' Улирал 2022',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 14),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 20,
                color: Color.fromARGB(255, 255, 255, 255),
              )
            ],
          ),
        ),
      ),
    );
//
  }
}

class SeasonsList extends StatelessWidget {
  final List<dynamic> seasons;
  const SeasonsList({
    Key? key,
    required this.seasons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: seasons.length,
        itemBuilder: (BuildContext context, int index) {
          // GetSeason season = listSeason[index];
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      seasons[index]['season_name'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.Green,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        seasons[index]['start_date'],
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
