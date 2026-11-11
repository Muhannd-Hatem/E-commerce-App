import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<void> loginWithEmailAndPassword(String email, String password);
  Future<void> registerWithEmailAndPassword(String email, String password);
  Future<bool> authenticateWithGoogle();
  Future<bool> authenticateWithFacebook();
  User? get currentUser; // تم تحويلها إلى Getter
  Future<void> logout();
}

class AuthServicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user != null;
  }

  @override
  Future<bool> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user != null;
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser; // تم تعديلها هنا أيضاً

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await FacebookAuth.instance.logOut();
    await GoogleSignIn.instance.signOut();
  }

  @override
  Future<bool> authenticateWithGoogle() async {
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize();

    final gUser = await googleSignIn.authenticate();
    final gAuth = gUser.authentication;

    final credential = GoogleAuthProvider.credential(idToken: gAuth.idToken);

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user != null;
  }

  @override
  Future<bool> authenticateWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();

    if (loginResult.status != LoginStatus.success) {
      return false;
    }

    final credential = FacebookAuthProvider.credential(
      loginResult.accessToken!.tokenString,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    if (userCredential.user != null) {
      return true;
    } else {
      return false;
    }
  }
}
