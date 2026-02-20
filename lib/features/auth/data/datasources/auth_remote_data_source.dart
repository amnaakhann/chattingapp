import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> getCurrentUser();
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
}

class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final fb.FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  FirebaseAuthRemoteDataSource({required this.firebaseAuth, required this.googleSignIn});

  @override
  Future<UserModel?> getCurrentUser() async {
    final u = firebaseAuth.currentUser;
    if (u == null) return null;
    return UserModel(
      uid: u.uid,
      displayName: u.displayName,
      email: u.email,
      photoUrl: u.photoURL,
    );
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    // This method intentionally kept simple; it integrates with google_sign_in.
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw Exception('User cancelled Google sign in');

    final googleAuth = await googleUser.authentication;
    final credential = fb.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    final u = userCredential.user!;
    return UserModel(uid: u.uid, displayName: u.displayName, email: u.email, photoUrl: u.photoURL);
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }
}
