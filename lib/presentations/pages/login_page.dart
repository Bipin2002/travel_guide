// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_tourist_guide/presentations/pages/signup_page.dart';
import 'package:smart_tourist_guide/presentations/widgets/custom_login_btn.dart';
import 'package:smart_tourist_guide/presentations/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = 'login-page';
  LoginPage({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
              Text('Login', style: Theme.of(context).textTheme.headline2),
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomTextFields(
                      controller: email,
                      iconData: Icons.email_outlined,
                      title: 'email', 
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomTextFields(
                      controller: password,
                      iconData: Icons.lock,
                      isobs: true,
                      title: 'password',
                       color: Colors.black,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget your password ?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomLoginbtn(
                email: email,
                password: password,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Don\'t have an account ?',
                style: TextStyle(color: Colors.black),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, SignUpPage.routeName);
                },
                child: Text(
                  'REGISTER',
                  style:
                      TextStyle(letterSpacing: 2, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
