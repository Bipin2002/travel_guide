import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tourist_guide/business_logic/auth/auth_bloc.dart';
import 'package:smart_tourist_guide/presentations/pages/login_page.dart';
import 'package:smart_tourist_guide/presentations/pages/onboarding__page.dart';
import 'package:smart_tourist_guide/presentations/screens/main_screen.dart';

class AuthPage extends StatelessWidget {
  static const String routeName = 'auth-page';
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitialState) {
              return OnBoardingPage();
            } else if (state is AuthloadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AuthsuccessState) {
              return MainScreen();
            } else if (state is AuthfailureState) {
              return LoginPage();
            }
            return Container(
              child: Text(
                'some error occured .',
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          },
        ),
      ),
    );
  }
}
