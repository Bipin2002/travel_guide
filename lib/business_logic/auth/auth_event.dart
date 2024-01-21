// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  
  });
  @override
  List<Object> get props => [email, password];
}
class SignupEvent extends AuthEvent {
  final String email;
  final String password;
    final String name;
  //final String date;
  SignupEvent({
    required this.email,
    required this.password,
     // required this.date,
    required this.name,
  });
  @override
  List<Object> get props => [email, password,name];//, date];
}
class LogoutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
