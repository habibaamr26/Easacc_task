import 'dart:developer';

import 'package:easacc_task/core/errors/exceptions.dart';
import 'package:easacc_task/feature/auth/data/data_source/auth_remote_data_source.dart';
import 'package:easacc_task/feature/auth/presentation/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final GoogleSignInService service;
  final FirebaseAuth _auth;

  GoogleAuthCubit(this.service, {FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance,
      super(GoogleAuthInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleAuthLoading());

    try {
      await service.signInWithGoogle();
      emit(GoogleAuthSuccess());
    } on FirebaseCustomException catch (e) {
      emit(GoogleAuthFailure(e.message));
    } catch (e) {
      emit(GoogleAuthFailure("Error occurred. Please try again."));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(GoogleAuthLoading());

    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;

        if (accessToken == null) {
          emit(GoogleAuthFailure("unable to obtain access token"));
          return;
        }

        final OAuthCredential credential = FacebookAuthProvider.credential(
          accessToken.tokenString,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );

        emit(GoogleAuthSuccess());
      } else if (result.status == LoginStatus.cancelled) {
        emit(GoogleAuthFailure("User cancelled the login process."));
      } else {
        emit(
          GoogleAuthFailure(
            "Login failed: ${result.message ?? 'Unknown error'}",
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(GoogleAuthFailure("Firebase error: ${e.message}"));
    } catch (e) {
      emit(GoogleAuthFailure("Error: $e"));
    }
  }
}
