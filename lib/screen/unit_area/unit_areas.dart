import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/services/commons/apis.dart';
import 'package:mvvm/widget/cached_network_image.dart';
import '../../models/unit_area.dart';
import '../../services/geo_service.dart';
import '../insight screen/insight_screen.dart';

class AllUnitAreas extends StatefulWidget {
  const AllUnitAreas({super.key});

  @override
  State<AllUnitAreas> createState() => AllUnitAreasState();
}

class AllUnitAreasState extends State<AllUnitAreas> {
  int currentIndex = 0;
  List<UnitArea> areas = [];

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    GeoService.getGeoUnitArea().then((value) {
      areas = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 12,
            ),
            child: Text(
              'Талбайн жагсаалт',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Бүх талбай',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: areas.length,
              itemBuilder: (context, index) {
                return UnitAreaItem(
                  unitArea: areas[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class UnitAreaItem extends StatelessWidget {
  UnitAreaItem({
    Key? key,
    this.unitArea,
  }) : super(key: key);
  UnitArea? unitArea;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: MyCachedNetworkImage(
                    imageUrl: main_host_url.toString() + "/" + unitArea!.parcel_image!.replaceAll("..", ""),
                    borderRadius: 10,
                    fit: BoxFit.contain,
                    isPlaceHolder: true,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AutoSizeText(
                    '${unitArea!.address_streetname} ${unitArea?.area_ha ?? 0} га',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: unitArea!.cult_names!.split(",").map((e) {
                      return Text(
                        e.toString(),
                        textAlign: TextAlign.start,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                formatDate,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red,
                ),
                child: const Center(
                  child: Text(
                    '-0.01',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
