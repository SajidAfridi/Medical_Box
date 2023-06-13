import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_box/features/authentication/login_page.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  Stream<User?> get authChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> login(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Logged In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  Future<String?> uid() async {
    return await _firebaseAuth.currentUser?.uid;
  }

  Future<Object?> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return LogInScreen();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
