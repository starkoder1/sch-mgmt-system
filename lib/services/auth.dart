import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // AuthService();
  final _firebaseAuth = FirebaseAuth.instance;
  late String? errrMsg;

  //handle sign in
  Future<User?> userSignIn(String userEmail, String userPass) async {
    try {
      final userData = await _firebaseAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPass);
      return userData.user;
    } on FirebaseAuthException catch (e) {
      errrMsg = e.toString();
      return null;
    }
  }
}
