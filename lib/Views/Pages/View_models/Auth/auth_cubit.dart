import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:ecommerce_app/Views/Pages/utils/api_path.dart';
import 'package:ecommerce_app/models/user_data.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/firestore_servises.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authServices = AuthServicesImpl();
  final firestoreServices = FirestoreServices.instance;

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await authServices.loginWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
        emit(AuthDone());
      } else {
        emit(AuthError(message: 'Failed to login'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    String userName,
  ) async {
    emit(AuthLoading());
    try {
      final result = await authServices.registerWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
        await _saveUserData(userName, email);
        emit(AuthDone());
      } else {
        emit(AuthError(message: 'Failed to register'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _saveUserData(String userName, String email) async {
    final currentUser = authServices.currentUser;
    final userData = UserData(
      id: currentUser!.uid,
      email: currentUser.email!,
      userName: userName,
      createdAt: DateTime.now().toIso8601String(),
    );
    await firestoreServices.setData(
      path: ApiPath.users(userData.id),
      data: userData.toMap(),
    );
  }

  void checkCurrentUser() {
    emit(AuthLoading());

    final user = authServices.currentUser;
    if (user != null) {
      emit(AuthDone());
    }
  }

  Future<void> logout() async {
    emit(AuthLoggingOut());
    try {
      await authServices.logout();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthLoggingOutError(message: e.toString()));
    }
  }

  Future<void> authenticateWithGoogle() async {
    emit(GoogleAuthenticating());
    try {
      final result = await authServices.authenticateWithGoogle();
      if (result) {
        emit(GoogleAuthenticationDone());
      } else {
        emit(
          GoogleAuthenticationError(
            message: 'Failed to authenticate with Google',
          ),
        );
      }
    } catch (e) {
      emit(GoogleAuthenticationError(message: e.toString()));
    }
  }

  Future<bool> authenticateWithFacebook() async {
    try {
      // 1. إجبار فيسبوك على استخدام الطريقة التقليدية لتجنب التوكن المحدود
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile'],
        loginBehavior:
            LoginBehavior.dialogOnly, // 👈 هذا السطر يحل مشكلة التوكن المحدود
      );

      if (result.status == LoginStatus.success) {
        // 2. الحصول على Access Token
        final AccessToken accessToken = result.accessToken!;

        // 3. إنشاء Credential لـ Firebase
        final OAuthCredential credential = FacebookAuthProvider.credential(
          accessToken.tokenString,
        );

        // 4. تسجيل الدخول في Firebase Auth
        await FirebaseAuth.instance.signInWithCredential(credential);
        return true;
      } else {
        print(
          'Facebook Login Status: ${result.status}, Message: ${result.message}',
        );
        return false;
      }
    } catch (e) {
      print('Exact Facebook Auth Error: $e');
      return false;
    }
  }
}
