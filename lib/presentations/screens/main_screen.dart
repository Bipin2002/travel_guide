// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_tourist_guide/data/local_storage/share_preference.dart';
import 'package:smart_tourist_guide/presentations/screens/discover_screen.dart';
import 'package:smart_tourist_guide/presentations/screens/home_screen.dart';
import 'package:smart_tourist_guide/presentations/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main-screen';
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = [
    HomeScreen(),
    DiscoverScreen(),
    ProfileScreen(),
  ];
  List<Widget> pages1 = [
    HomeScreen(),
    ProfileScreen(),
  ];

  int currentpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentpage],
      bottomNavigationBar: FutureBuilder(
        future: LocalStorage().readdata(),
        builder: (context, sna1) {
          if (sna1.data.toString() == "bipin@gmail.com") {
            return BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Color.fromARGB(255, 69, 68, 68),
              currentIndex: currentpage,
              onTap: (index) {
                setState(() {
                  currentpage = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 25,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.play_circle_outlined,
                    size: 25,
                  ),
                  label: 'Discover',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.logout,
                    size: 25,
                  ),
                  label: 'Profile',
                ),
              ],
            );
          } else {
            return Scaffold(
              body: pages1[currentpage],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.black,
                unselectedItemColor: Color.fromARGB(255, 69, 68, 68),
                currentIndex: currentpage,
                onTap: (index) {
                  setState(() {
                    currentpage = index;
                  });
                  // Navigate to the ProfileScreen when the "Profile" label is tapped
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 25,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.logout,
                      size: 25,
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
