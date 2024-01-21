import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> signup(
      {required String email,
      required String password,
      required String name,
     // required String date
      }) async {
    final user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.user!;
  }

  Future<User> login({required String email, required String password}) async {
    final user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user!;
  }

  Future sigout() async {
    await auth.signOut();
  }

  Future<bool> isSignedIn() async {
    final user = auth.currentUser;
    return user != null;
  }

  Future<User> getuser() async {
    final user = auth.currentUser;
    return user!;
  }
}
