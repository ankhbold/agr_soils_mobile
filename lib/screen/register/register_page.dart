import 'package:flutter/material.dart';
import 'package:mvvm/models/position_type.dart';

import '../../models/company.dart';
import '../../models/register_info.dart';
import '../../services/register_service.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/loader.dart';
import '../../widget/outlined_btn.dart';
import '../../widget/snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

///2842815
class RegisterPageState extends State<RegisterPage> {
  TextEditingController organizationRegisterNumController = TextEditingController();
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController registerNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  CompanyInfo? companyInfo;
  String? selectedPositionType;
  int? selectedPositionTypeId;
  List<PositionType> positionTypes = [];
  bool isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    RegisterService.getPositionTypes().then((value) {
      positionTypes = value;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 20),
      physics: AlwaysScrollableScrollPhysics(),
      child: Form(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Регистрийн дугаар хайх',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: organizationRegisterNumController,
                context: context,
                labelText: '',
                onChanged: (value) {
                  if (value.length == 7) {
                    LoadingIndicator(context: context).showLoadingIndicator();
                    RegisterService.registerNoSearchOrganization(registerNo: value).then((value) {
                      LoadingIndicator(context: context).hideLoadingIndicator();
                      companyInfo = value;
                      organizationNameController.text = value.name!;
                      setState(() {});
                    }).catchError((onError) {
                      LoadingIndicator(context: context).hideLoadingIndicator();
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(
                          message: onError.toString(),
                        ),
                      );
                    });
                  }
                },
                maxLength: 7,
              ),
              Text(
                'Байгууллагын нэр',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                readOnly: true,
                controller: organizationNameController,
                context: context,
                labelText: '',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Албан тушаалаа сонгоно уу',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1,
                    color: Color(0xffD9D9D9),
                  ),
                ),
                child: DropdownButton(
                  alignment: AlignmentDirectional.center,
                  hint: Text('Албан тушаалаа сонгоно уу'),
                  value: selectedPositionType,
                  borderRadius: BorderRadius.circular(20),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  underline: Container(),
                  items: positionTypes.map((item) {
                    return DropdownMenuItem(
                      value: item.name,
                      child: Text(item.name!),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPositionType = newValue;
                      selectedPositionTypeId = positionTypes.singleWhere((element) => element.name == newValue).id;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Овог',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: lastNameController,
                context: context,
                labelText: '',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Нэр',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: firstNameController,
                context: context,
                labelText: '',
              ),
              Text(
                'Регистрийн дугаар',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: registerNumberController,
                context: context,
                labelText: '',
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Нэвтрэх Нэр',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: userNameController,
                context: context,
                labelText: '',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Утасны дугаар',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: phoneNumberController,
                context: context,
                labelText: '',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Цахим шуудан',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: emailController,
                context: context,
                labelText: '',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Нууц үг үүсгэх *',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: passwordController,
                context: context,
                obscureText: !isPasswordVisible,
                suffix: isPasswordVisible
                    ? const Icon(
                        Icons.visibility,
                        color: Color(0xff065F46),
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: Color(0xff065F46),
                      ),
                suffixIconOnPressed: () {
                  isPasswordVisible = !isPasswordVisible;
                  setState(() {});
                },
                labelText: '',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Нууц үг давтах *',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: repeatPasswordController,
                context: context,
                obscureText: !isPasswordVisible,
                labelText: '',
                suffix: isPasswordVisible
                    ? const Icon(
                        Icons.visibility,
                        color: Color(0xff065F46),
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: Color(0xff065F46),
                      ),
                suffixIconOnPressed: () {
                  isPasswordVisible = !isPasswordVisible;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, bottom: MediaQuery.of(context).viewInsets.bottom),
                child: CustomOutlinedBtn(
                  text: 'Бүртгүүлэх',
                  textColor: Colors.white,
                  color: Color(0xff065F46),
                  onTap: () {
                    RegisterInfo registerInfo = RegisterInfo(
                      person_register: registerNumberController.text,
                      prof_company_id: companyInfo!.prof_company_id,
                      firstname: firstNameController.text,
                      position_type_id: selectedPositionTypeId,
                      lastname: lastNameController.text,
                      email: emailController.text,
                      username: userNameController.text,
                      phone: phoneNumberController.text,
                      password: passwordController.text,
                    );
                    LoadingIndicator(context: context).showLoadingIndicator();
                    RegisterService.register(registerInfo: registerInfo).then((value) {
                      LoadingIndicator(context: context).hideLoadingIndicator();
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(
                          message: "Амжилттай бүртгүүллээ",
                        ),
                      );
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
