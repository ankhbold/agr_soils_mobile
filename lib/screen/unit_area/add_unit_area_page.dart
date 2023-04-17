import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../models/cultivation_type.dart';
import '../../models/unit_area_create_request.dart';
import '../../services/cultivation.dart';
import '../../services/unit_area.dart';
import '../../widget/cached_network_image.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/line.dart';
import '../../widget/loader.dart';
import '../../widget/outlined_btn.dart';
import '../../widget/snackbar.dart';

// ignore: must_be_immutable
class AddUnitAreaPage extends StatefulWidget {
  AddUnitAreaPage({this.back, this.polygonPoints, this.success});
  Function? back;
  Function? success;
  List<LatLng>? polygonPoints;
  @override
  State<StatefulWidget> createState() {
    return AddUnitAreaPageState();
  }
}

class AddUnitAreaPageState extends State<AddUnitAreaPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  List<CultivationType> types = [];
  String? selectedType;
  int? currentTypeIndex = -1;
  List<List<double>> locationPoints = [];
  @override
  void initState() {
    super.initState();

    CultivationService.getCultivationType().then((value) {
      types = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              widget.back!();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'буцах',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.blue),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: MyCachedNetworkImage(
                      borderRadius: 20,
                      imageUrl:
                          "https://9to5google.com/wp-content/uploads/sites/4/2017/07/chrome_2017-07-25_12-59-01.jpg?quality=82&strip=all&w=1445",
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Талбай 1',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '4.1 ha',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Line3(),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(text: 'Талбайн  нэр'),
                      TextSpan(
                          text: ' *',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 15, color: Colors.red)),
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                context: context,
                controller: nameController,
                onChanged: (value) {},
                borderRadius: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: CustomTextField(
                  controller: descController,
                  textInputType: TextInputType.multiline,
                  labelText: 'Таны тайлбар',
                  context: context,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(text: 'Тариалалтын төрөл'),
                    TextSpan(
                        text: ' *',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 15, color: Colors.red)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton(
                alignment: AlignmentDirectional.topStart,
                hint: Text('Тариалалтын төрлөө сонгоно уу'),
                value: selectedType,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: types.map((item) {
                  return DropdownMenuItem(
                    value: item.name,
                    child: Text(item.name!),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    currentTypeIndex = types.indexOf(types.singleWhere((element) => element.name == newValue));
                    selectedType = newValue;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          CustomOutlinedBtn(
            color: Color(0xff065F46),
            textColor: Colors.white,
            text: 'Хадгалах',
            onTap: () {
              widget.polygonPoints!.forEach((element) {
                locationPoints.add([element.longitude, element.latitude]);
              });
              CreateUnitAreaModelRequest createUnitAreaModelRequest = CreateUnitAreaModelRequest(
                description: descController.text,
                field_name: nameController.text,
                cult_type: types[currentTypeIndex!].id,
                geom: locationPoints,
              );
              LoadingIndicator(context: context).showLoadingIndicator();
              UnitAreaService().createUnitArea(createUnitAreaModelRequest: createUnitAreaModelRequest).then((value) {
                LoadingIndicator(context: context).hideLoadingIndicator();
                ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                  message: 'Амжилттай талбай нэмэгдлээ',
                ));
                widget.success!();
              }).catchError((onError) {
                LoadingIndicator(context: context).hideLoadingIndicator();
                ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                  message: onError.toString(),
                ));
              });
            },
          )
        ],
      ),
    );
  }
}
