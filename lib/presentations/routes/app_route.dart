
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_tourist_guide/presentations/pages/auth_screen.dart';
import 'package:smart_tourist_guide/presentations/pages/individual_pages.dart';
import 'package:smart_tourist_guide/presentations/pages/login_page.dart';
import 'package:smart_tourist_guide/presentations/pages/onboarding__page.dart';
import 'package:smart_tourist_guide/presentations/pages/signup_page.dart';
import 'package:smart_tourist_guide/presentations/screens/home_screen.dart';
import 'package:smart_tourist_guide/presentations/screens/main_screen.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case MainScreen.routeName:
        return MaterialPageRoute(builder: (context) => MainScreen());
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case SignUpPage.routeName:
        return MaterialPageRoute(builder: (context) => SignUpPage());
      case OnBoardingPage.routeName:
        return MaterialPageRoute(builder: (context) => OnBoardingPage());
      case AuthPage.routeName:
        return MaterialPageRoute(builder: (context) => AuthPage());
      case IndividualPages.routeName:
        return MaterialPageRoute(builder: (context) => IndividualPages(aa: routeSettings.arguments as QueryDocumentSnapshot<Object?>,));

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text(
                      'No route found',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ));
    }
  }
}
