import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../models/unit_area.dart';
import '../../services/commons/apis.dart';
import '../../services/geo_service.dart';
import '../../widget/cached_network_image.dart';
import '../field screen/field.dart';
import '../insight screen/insight_screen.dart';

class AllUnitAreas extends StatefulWidget {
  AllUnitAreas({super.key, this.isAll = false, this.tabController});
  bool? isAll;
  PersistentTabController? tabController;
  @override
  State<AllUnitAreas> createState() => AllUnitAreasState();
}

class AllUnitAreasState extends State<AllUnitAreas> {
  int currentIndex = 0;
  List<UnitArea> areas = [];
  List<UnitArea> currentAreas = [];

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    GeoService.getGeoUnitArea().then((value) {
      areas = value;
      currentAreas = areas;
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
            padding: EdgeInsets.only(
              top: widget.isAll! ? 0 : 10,
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
          widget.isAll!
              ? CupertinoSearchTextField(
                  placeholder: "Талбай хайх",
                  onChanged: (String value) {
                    currentAreas = currentAreas
                        .where((element) => (element.address_streetname != null &&
                            element.address_streetname!.toLowerCase().contains(value.toLowerCase())))
                        .toList();

                    if (value == '') {
                      currentAreas = areas;
                    }
                    setState(() {});
                  },
                  onSubmitted: (String value) {
                    currentAreas = currentAreas
                        .where((element) => (element.address_streetname != null &&
                            element.address_streetname!.toLowerCase().contains(value.toLowerCase())))
                        .toList();
                    if (value == '') {
                      currentAreas = areas;
                    }
                    setState(() {});
                  },
                )
              : Container(),
          widget.isAll!
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                'Бүх талбай',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: 150,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Ургац нэмэх',
                          style: TextStyle(
                            color: Color(0xff40A027),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Container(),
          Container(
            height: widget.isAll! ? MediaQuery.of(context).size.height - 330 : MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: currentAreas.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    UnitAreaMove(
                      LatLng(
                        double.parse(currentAreas[index].coord_y!),
                        double.parse(currentAreas[index].coord_x!),
                      ),
                    );
                    widget.tabController!.jumpToTab(0);
                  },
                  child: UnitAreaItem(
                    unitArea: currentAreas[index],
                  ),
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
    return Row(
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
                  imageUrl: main_host_url.toString() +
                      "/" +
                      (unitArea!.parcel_image != null ? unitArea!.parcel_image!.replaceAll("..", "") : ""),
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
                  '${unitArea?.address_streetname ?? ""} ${unitArea?.area_ha ?? 0} га',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  maxLines: 3,
                  textAlign: TextAlign.start,
                ),
                unitArea!.cult_names!.isNotEmpty
                    ? Row(
                        children: unitArea!.cult_names!.split(",").map((e) {
                          return Text(
                            e ?? '',
                            textAlign: TextAlign.start,
                          );
                        }).toList(),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Text(
              formatDate ?? '',
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
    );
  }
}
