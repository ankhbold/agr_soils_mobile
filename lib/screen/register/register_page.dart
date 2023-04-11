import 'package:flutter/material.dart';

import '../../widget/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController organizationRegisterNumController = TextEditingController();
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          ],
        ),
      ),
    );
  }
}
