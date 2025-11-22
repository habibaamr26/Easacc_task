
import 'package:easacc_task/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class FirebaseErrorHandler {
  static String mapErrorToMessage(Object e) {
    // Firebase Auth Errors
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          return 'هذا الحساب موجود من قبل بطريقة تسجيل مختلفة.';
        case 'invalid-credential':
          return 'بيانات اعتماد غير صالحة.';
        case 'user-disabled':
          return 'تم تعطيل الحساب.';
        case 'network-request-failed':
          return 'خطأ في الاتصال بالإنترنت. حاول مرة أخرى.';
        default:
          return 'حدث خطأ في Firebase: ${e.message}';
      }
    } 
    // Client-side errors (مثل إلغاء المستخدم أو مشكلة الإنترنت)
    else if (e is FirebaseCustomException) {
      return e.message;
    } 
    // Network errors
    else if (e is SocketException) {
      return 'لا يوجد اتصال بالإنترنت. تحقق من الشبكة وحاول مرة أخرى.';
    } 
    // أي خطأ غير متوقع
    else {
      return 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.';
    }
  }
}
