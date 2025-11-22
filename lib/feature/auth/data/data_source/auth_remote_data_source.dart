import 'dart:io';
import 'package:easacc_task/core/errors/error_handler.dart';
import 'package:easacc_task/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialize = false;

  static List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  static Future<void> initSignIn() async {
    try {
      if (!isInitialize) {
        await _googleSignIn.initialize();
        isInitialize = true;
      }
    } catch (e) {
      print('Failed to initialize Google Sign-In: $e');
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      await initSignIn();

      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();
      if (googleUser == null) {
        throw FirebaseCustomException("Sign-in was cancelled by the user.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Server-side Firebase errors
      final readableMessage = FirebaseErrorHandler.mapErrorToMessage(e);
      throw FirebaseCustomException(readableMessage);
    } on SocketException {
      // Client-side network error
      throw FirebaseCustomException(
        'No internet connection. Please check your network settings.',
      );
    } catch (e) {
      // Unexpected errors
      final readableMessage = FirebaseErrorHandler.mapErrorToMessage(e);
      throw FirebaseCustomException(readableMessage);
    }
  }
}
