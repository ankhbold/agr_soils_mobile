import 'package:flutter/material.dart';

import '../../widget/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController organizationRegisterNumController = TextEditingController();
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
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
              height: 20,
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
          ],
        ),
      ),
    );
  }
}
