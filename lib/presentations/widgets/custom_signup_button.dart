import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tourist_guide/business_logic/auth/auth_bloc.dart';
import 'package:smart_tourist_guide/data/local_storage/share_preference.dart';
import 'package:smart_tourist_guide/data/repo/location_repo.dart';
import 'package:smart_tourist_guide/presentations/screens/main_screen.dart';
import 'package:smart_tourist_guide/presentations/widgets/show_snackbar.dart';

class CustomSignUpbtn extends StatefulWidget {
  const CustomSignUpbtn({
    Key? key,
    required this.email,
    required this.password,
   // required this.date,
    required this.name,
  }) : super(key: key);

  final TextEditingController email;
  final TextEditingController password;
  //final TextEditingController date;
  final TextEditingController name;

  @override
  State<CustomSignUpbtn> createState() => _CustomSignUpbtnState();
}

class _CustomSignUpbtnState extends State<CustomSignUpbtn> {
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
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isclicked = true;
            });
            if (widget.name.text.isNotEmpty &&
                widget.email.text.isNotEmpty
            
                ) {
              context.read<AuthBloc>().add(SignupEvent(
                  email: widget.email.text,
                  password: widget.password.text,
           
                  name: widget.name.text));
              WriteRepo().userinfo(
                  name: widget.name.text,
                  email: widget.email.text
                  );
              LocalStorage().writedata(text: widget.email.text);
            } else {
              snowsnackBar(
                  context: context,
                  child: Container(
                    child: Text('please fill all fields'),
                  ));
            }
          },
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
                child: Text(
              'SIGN UP',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 1.5),
            )),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}
