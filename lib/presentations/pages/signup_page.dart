// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:smart_tourist_guide/presentations/pages/login_page.dart';
import 'package:smart_tourist_guide/presentations/widgets/custom_signup_button.dart';
import 'package:smart_tourist_guide/presentations/widgets/custom_text_field_with_border.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = 'signup-page';
  SignUpPage({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
 // TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              topContainer(context),
              bodyContainer(),
              SizedBox(
                height: 20,
              ),
              CustomSignUpbtn(
                  email: email, password: password, name: name),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Registered ? ',
                    style: TextStyle(
                        fontSize: 20, color: Colors.black, letterSpacing: 1.6),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LoginPage.routeName);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 20, color: Colors.cyan, letterSpacing: 1.6),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container bodyContainer() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customeTitle(title: 'Please enter your name'),
          CustomField(
            controller: name,
            title: 'Name',
          ),
          customeTitle(title: 'Please enter Email'),
          CustomField(
            controller: email,
            title: 'e-mail',
          ),
          customeTitle(title: 'Please enter your password'),
          CustomField(
            controller: password,
            title: 'password',
          ),
          // customeTitle(title: 'Please enter your Date of Birth'),
          // CustomField(
          //   controller: date,
          //   title: 'Date of Birth',
          // ),
        ],
      ),
    );
  }

  Padding customeTitle({required title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.black, letterSpacing: 1.5),
      ),
    );
  }

  Container topContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 100,
            width: 300,
            child: Text(
              'Create new Account',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          
        ],
      ),
    );
  }
}
