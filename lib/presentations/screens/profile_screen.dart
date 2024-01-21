// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tourist_guide/business_logic/auth/auth_bloc.dart';
import 'package:smart_tourist_guide/data/local_storage/share_preference.dart';
import 'package:smart_tourist_guide/presentations/pages/login_page.dart';
import 'package:smart_tourist_guide/presentations/screens/main_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
               
                //image
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.25,
                  right: MediaQuery.of(context).size.width * 0.25,
                  top: 80,
                  child: CircleAvatar(
                    radius: 85,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/images/user2.png'),
                    ),
                  ),
                ),
                BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthsuccessState) {
                        Navigator.pushReplacementNamed(
                            context, LoginPage.routeName);
                      } else if (state is AuthfailureState) {
                        Navigator.pushReplacementNamed(
                            context, LoginPage.routeName);
                      }
                    },
                    child: Container()),
                Positioned(
                  top: 250,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Column(
                      children: [
                        //name
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: FutureBuilder(
                              future: LocalStorage().readdata(),
                              builder: (context, snapshot) {
                                return StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('userinfo')
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snap) {
                                      return SizedBox(
                                        height: 40,
                                        child: ListView.builder(
                                            itemCount: snap.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              if (snapshot.data.toString() ==
                                                  snap.data!.docs[index]
                                                      ['email']) {
                                                return Text(
                                                  snap.data!.docs[index]['name']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black
                                                      ),
                                                      textAlign: TextAlign.center,
                                                );
                                                
                                              } else {
                                                return SizedBox();
                                              }
                                            }),
                                      );
                                    });
                              }),
                        ),

                        //edit box
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MaterialButton(
                            minWidth: 200,
                            height: 50,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () {},
                            child: Text('Edit Profile'),
                          ),
                        ),

                        //contaner

                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blueGrey),
                          child: Column(
                            children: [
                              buildListTile(
                                tap: () {},
                                text: 'Settings',
                                iconData: Icons.settings,
                              ),
                              buildListTile(
                                tap: () {},
                                text: 'Customer Support',
                                iconData: Icons.support_agent_rounded,
                              ),
                              buildListTile(
                                tap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("Logout ?"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("No"),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Navigator.of(ctx).pop();
                                            context
                                                .read<AuthBloc>()
                                                .add(LogoutEvent());
                                            // LocalStorage().clear(key: 'text');
                                            // LocalStorage().clear(key: 'imageurl');
                                            // Navigator.pushReplacementNamed(
                                            //     context, LoginPage.routeName);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("yes"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                text: 'Sign Out',
                                iconData: Icons.logout,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, MainScreen.routeName);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile buildListTile(
      {required VoidCallback tap,
      required String text,
      required IconData iconData}) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.white,
      ),
      title: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: tap,
        icon: Icon(
          Icons.arrow_forward_ios_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
