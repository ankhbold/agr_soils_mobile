import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/create_season_model.dart';
import '../../models/season.dart';
import '../../services/season.dart';
import '../../utils/date_manager.dart';
import '../../widget/custom_outlined_icon_btn.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/line.dart';
import '../../widget/loader.dart';
import '../../widget/outlined_btn.dart';
import '../../widget/snackbar.dart';

// ignore: must_be_immutable
class CreateSeasonPage extends StatefulWidget {
  Function? success;
  bool? isEdit;
  Season? season;
  CreateSeasonPage({this.success, this.isEdit = false, this.season});
  @override
  State<StatefulWidget> createState() {
    return CreateSeasonPageState();
  }
}

class CreateSeasonPageState extends State<CreateSeasonPage> {
  TextEditingController seasonNameController = TextEditingController();
  DateTime currentDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    if (widget.isEdit!) {
      seasonNameController.text = widget.season!.season_name!;
      startDate = DateTime.parse(widget.season!.start_date!);
      endDate = DateTime.parse(widget.season!.end_date!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.isEdit! ? 'Улирал засах' : 'Шинэ Улирал нэмэх',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Line4(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Улирлын нэр',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                context: context,
                controller: seasonNameController,
                borderRadius: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Эхлэх огноо',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                      InkWell(
                        onTap: () {
                          selectDatePicker(isStart: true);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 30,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xffDADADA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.date_range),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                MyDateManager.getMonthNametoString(dateTime: startDate).toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Дуусах огноо',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          selectDatePicker(isEnd: true);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 30,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xffDADADA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.date_range),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                MyDateManager.getMonthNametoString(dateTime: endDate).toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              widget.isEdit!
                  ? Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomOutlinedIconBtn(
                          isPrefix: true,
                          icon: Image.asset(
                            "assets/common/remove.png",
                            color: Colors.red,
                            width: 30,
                            height: 30,
                          ),
                          color: Colors.white,
                          textColor: Colors.red,
                          text: 'Улирал устгах',
                          onTap: () {
                            LoadingIndicator(context: context).showLoadingIndicator();
                            SeasonService().deleteSeason(season_id: widget.season!.season_id).then((value) {
                              LoadingIndicator(context: context).hideLoadingIndicator();
                              widget.success!();
                            }).catchError((onError) {
                              LoadingIndicator(context: context).hideLoadingIndicator();
                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar(
                                  message: onError.toString(),
                                ),
                              );
                            });
                          },
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
          CustomOutlinedBtn(
            color: Color(0xff065F46),
            textColor: Colors.white,
            text: 'Хадгалах',
            onTap: () {
              CreateSeasonModelRequest createSeasonModelRequest = CreateSeasonModelRequest(
                season_id: widget.isEdit! ? widget.season!.season_id : null,
                name: seasonNameController.text,
                start: startDate.toString(),
                end: endDate.toString(),
              );
              LoadingIndicator(context: context).showLoadingIndicator();
              if (widget.isEdit!) {
                SeasonService().updateSeason(createSeasonModelRequest: createSeasonModelRequest).then((value) {
                  LoadingIndicator(context: context).hideLoadingIndicator();
                  // print(value);
                  widget.success!();
                }).catchError((onError) {
                  print(onError.toString());
                  ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                    message: onError.toString(),
                  ));
                  LoadingIndicator(context: context).hideLoadingIndicator();
                });
              } else {
                SeasonService().createSeason(createSeasonModelRequest: createSeasonModelRequest).then((value) {
                  LoadingIndicator(context: context).hideLoadingIndicator();
                  widget.success!();
                }).catchError((onError) {
                  LoadingIndicator(context: context).hideLoadingIndicator();
                  ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                    message: onError.toString(),
                  ));
                });
              }
            },
          ),
        ],
      ),
    );
  }

  selectDatePicker({bool? isStart = false, bool? isEnd = false}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: isStart! ? startDate : endDate,
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                if (isStart) {
                  startDate = newDate;
                } else {
                  endDate = newDate;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
