import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'google_signin_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      debugPrint('AuthService: signing in $email');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Ensure we write a Map<String, dynamic>
      await _firestore.collection("Users").doc(userCredential.user!.uid).set(
        <String, dynamic>{'uid': userCredential.user!.uid, 'email': email},
      );
      debugPrint('AuthService: sign in successful ${userCredential.user!.uid}');
      return userCredential;
    } on FirebaseAuthException catch (e, st) {
      debugPrint('AuthService: sign in error ${e.code} ${e.message}');
      debugPrintStack(label: 'signInWithEmailPassword', stackTrace: st);
      // Rethrow the original FirebaseAuthException so callers can inspect code/message
      rethrow;
    } catch (e, st) {
      // Log unexpected errors (including type-cast errors from plugins)
      debugPrint('AuthService: unexpected error during signIn: $e');
      debugPrintStack(label: 'signInWithEmailPassword', stackTrace: st);
      // Rethrow so UI can handle it
      rethrow;
    }
  }

  // Register with email and password
  Future<UserCredential> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      debugPrint('AuthService: creating user $email');
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection("Users").doc(userCredential.user!.uid).set(
        <String, dynamic>{'uid': userCredential.user!.uid, 'email': email},
      );
      debugPrint('AuthService: user created ${userCredential.user!.uid}');
      return userCredential;
    } on FirebaseAuthException catch (e, st) {
      debugPrint('AuthService: sign up error ${e.code} ${e.message}');
      debugPrintStack(label: 'signUpWithEmailPassword', stackTrace: st);
      rethrow;
    } catch (e, st) {
      debugPrint('AuthService: unexpected error during signUp: $e');
      debugPrintStack(label: 'signUpWithEmailPassword', stackTrace: st);
      rethrow;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final account = await _googleSignInService.signIn();
      if (account == null) {
        // user cancelled the sign-in
        return null;
      }
      final auth = await _googleSignInService.getAuth(account);
      if (auth == null) return null;
      final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e, st) {
      debugPrint('AuthService: Google sign-in failed: $e');
      debugPrintStack(label: 'signInWithGoogle', stackTrace: st);
      rethrow;
    }
  }

  // Sign out (also from Google)
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignInService.signOut();
    } catch (e) {
      debugPrint('AuthService: error signing out: $e');
      rethrow;
    }
  }
}
