// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourist_guide/business_logic/auth/auth_bloc.dart';
import 'package:smart_tourist_guide/data/repo/user_repo.dart';
import 'package:smart_tourist_guide/presentations/pages/auth_screen.dart';
import 'package:smart_tourist_guide/presentations/pages/onboarding__page.dart';
import 'package:smart_tourist_guide/presentations/routes/app_route.dart';


int? initalscreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initalscreen = await preferences.getInt('initialScreen');
  await preferences.setInt('initialScreen', 1);

  await Firebase.initializeApp();

  runApp(MyApp(
    appRoute: AppRoute(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.appRoute}) : super(key: key);
  AppRoute appRoute;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(UserRepo())..add(AuthenticationEvent()),
        ),
   
    
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: initalscreen == 0 || initalscreen == null
            ? OnBoardingPage.routeName
            : AuthPage.routeName,
        onGenerateRoute: appRoute.onGenerateRoute,
        // home: AuthPage(),
      ),
    );
  }
}
