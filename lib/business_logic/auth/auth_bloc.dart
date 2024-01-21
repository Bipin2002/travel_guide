import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_tourist_guide/data/repo/user_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepo userRepo;
  AuthBloc(UserRepo repo)
      : userRepo = repo,
        super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthenticationEvent) {
        try {
          emit(AuthloadingState());
          final issignedin = await userRepo.isSignedIn();
          final user = await userRepo.getuser();
          if (issignedin) {
            emit(AuthsuccessState(user: user));
          } else {
            emit(AuthfailureState(message: 'some error occured'));
          }
        } catch (e) {
          emit(AuthfailureState(message: e.toString()));
        }
      } else if (event is LoginEvent) {
        try {
          emit(AuthloadingState());
          final user = await userRepo.login(
              email: event.email, password: event.password);
          emit(AuthsuccessState(user: user));
        } catch (e) {
          emit(AuthfailureState(message: e.toString()));
        }
      } else if (event is SignupEvent) {
        try {
          emit(AuthloadingState());
          final user = await userRepo.signup(
            name: event.name,//date: event.date,
              email: event.email, password: event.password);
          emit(AuthsuccessState(user: user));
        } catch (e) {
          emit(AuthfailureState(message: e.toString()));
        }
      } else if (event is LogoutEvent) {
        try {
          emit(AuthloadingState());
          final user = await userRepo.sigout();
          emit(AuthsuccessState(user: user));
        } catch (e) {
          emit(AuthfailureState(message: e.toString()));
        }
      }
    });
  }
}
