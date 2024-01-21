// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tourist_guide/data/local_storage/share_preference.dart';
import 'package:smart_tourist_guide/presentations/screens/main_screen.dart';

import '../../business_logic/auth/auth_bloc.dart';

class CustomLoginbtn extends StatefulWidget {
  const CustomLoginbtn({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  final TextEditingController email;
  final TextEditingController password;

  @override
  State<CustomLoginbtn> createState() => _CustomLoginbtnState();
}

class _CustomLoginbtnState extends State<CustomLoginbtn> {
  bool isclicked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isclicked == true
            ? BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthsuccessState) {
                    Navigator.pushReplacementNamed(
                        context, MainScreen.routeName);
                  }
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthInitialState) {
                      return SizedBox();
                    } else if (state is AuthloadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AuthsuccessState) {
                      return Container();
                    } else if (state is AuthfailureState) {
                      return Card(
                          child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(state.message),
                      ));
                    }
                    return Container(
                      child: Text('some error occured'),
                    );
                  },
                ),
              )
            : SizedBox(),
        MaterialButton(
          color: Colors.cyan,
          height: 60,
          minWidth: MediaQuery.of(context).size.width * 0.7,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            setState(() {
              isclicked = !isclicked;
            });
            context.read<AuthBloc>().add(
                  LoginEvent(
                      email: widget.email.text, password: widget.password.text),
                );
            LocalStorage().writedata(text: widget.email.text);
          },
          child: Text(
            'Login',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
                letterSpacing: 1.5),
          ),
        ),
      ],
    );
  }
}
