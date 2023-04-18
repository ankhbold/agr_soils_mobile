import 'package:flutter/material.dart';
import 'package:mvvm/models/company.dart';
import 'package:mvvm/models/register_info.dart';
import 'package:mvvm/services/register_service.dart';
import 'package:mvvm/widget/loader.dart';
import 'package:mvvm/widget/outlined_btn.dart';

import '../../widget/custom_text_field.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  CompanyInfo? companyInfo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 20),
      physics: AlwaysScrollableScrollPhysics(),
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
            SizedBox(
              height: 10,
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
              labelText: '',
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
              labelText: '',
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
                    prof_company_id: companyInfo!.prof_company_id,
                    firstname: firstNameController.text,
                    lastname: lastNameController.text,
                    phone: phoneNumberController.text,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
