import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthentication(this._firebaseAuth);

  Future<String> registerWithEmailAndPassword(String email, String password) async {
    try {
      var credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("✅ Success registerWithEmailAndPassword");
      return credential.user!.uid;
    } on FirebaseException catch (exception) {
      print("🛑 Error registerWithEmailAndPassword");
      print(exception.code);
      rethrow;
    }
  }

  Future<String> loginWithEmailAndPassword(String email, String password) async {
    try {
      var credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("✅ Success loginWithEmailAndPassword");
      return credential.user!.uid;
    } on FirebaseAuthException catch (exception) {
      print("🛑 Error loginWithEmailAndPassword");
      print(exception.message);
      rethrow;
    }
  }
}
