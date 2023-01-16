import 'package:flutter/material.dart';
import 'package:mvvm/constants/colors.dart';
import 'package:mvvm/screen/field%20screen/season/model_season.dart';

import 'season_rep.dart';

class easonsss extends StatefulWidget {
  const easonsss({super.key});

  @override
  State<easonsss> createState() => _easonsssState();
}

bool jans = true;
bool febs = false;
bool mars = false;

class _easonsssState extends State<easonsss> {
  List<SeasonModel> listSeason = [];
  RepositoryS repository = RepositoryS();
  getSeasonApi() async {
    listSeason = await repository.getSeasonApi();
    setState(() {});
  }

  @override
  void initState() {
    getSeasonApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView.builder(
        itemCount: listSeason.length,
        itemBuilder: (BuildContext context, int index) {
          SeasonModel seasons = listSeason[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Text(
                        '${seasons.seasonName}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 100,
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
                    padding: EdgeInsets.only(right: 140),
                    child: Text(
                      '${seasons.startDate}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Season extends StatelessWidget {
  const Season({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.33,
      height: MediaQuery.of(context).size.height * 0.04,
      child: FloatingActionButton.extended(
        // heroTag: Text("btn1"),
        backgroundColor: AppColors.Green.withOpacity(0.7),
        onPressed: () => showModalBottomSheet(
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
                  const easonsss(),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    flex: 1,
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
                  )
                ],
              ),
            );
          },
        ),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Улирал 2022',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 20,
              color: Color.fromARGB(255, 255, 255, 255),
            )
          ],
        ),
      ),
    );
//
  }
}

class Seasonsss extends StatefulWidget {
  const Seasonsss({super.key});

  @override
  State<Seasonsss> createState() => _SeasonsssState();
}

bool jan = true;
bool feb = false;
bool mar = false;

class _SeasonsssState extends State<Seasonsss> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CheckboxListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                'Арвин-Хур 2022 он',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
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
          subtitle: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
            child: Text(
              'April 1 - Dec 31, 2022',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          checkColor: AppColors.Green,
          activeColor: AppColors.whiteColor,
          value: jan,
          onChanged: (val) {
            setState(() {
              if (jan = true) {
                feb = false;
                mar = false;
              }
            });
          },
        ),
        CheckboxListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                'Арвин-Хур 2022 он',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
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
          subtitle: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
            child: Text(
              'April 1 - Dec 31, 2022',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          value: feb,
          checkColor: AppColors.Green,
          activeColor: AppColors.whiteColor,
          onChanged: (val) {
            setState(() {
              if (feb = true) {
                jan = false;
                mar = false;
              }
            });
          },
        ),
        CheckboxListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                'Арвин-Хур 2022 он',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
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
          subtitle: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
            child: Text(
              'April 1 - Dec 31, 2022',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          value: mar,
          checkColor: AppColors.Green,
          activeColor: AppColors.whiteColor,
          onChanged: (val) {
            setState(() {
              if (mar = true) {
                feb = false;
                jan = false;
              }
            });
          },
        ),
      ],
    );
  }
}

class Seasons extends StatelessWidget {
  const Seasons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(
                Icons.check,
                color: AppColors.Green,
                size: 30,
              ),
            ),
            Text(
              'Арвин-Хур 2022 он',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 100,
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
        const Padding(
          padding: EdgeInsets.only(right: 140),
          child: Text(
            'April 1 - Dec 31, 2022',
            style: TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

class Seasonss extends StatelessWidget {
  const Seasonss({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            SizedBox(
              width: 35,
            ),
            Text(
              'Арвин-Хур 2022 он',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 100,
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
        const Padding(
          padding: EdgeInsets.only(right: 140),
          child: Text(
            'April 1 - Dec 31, 2022',
            style: TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
