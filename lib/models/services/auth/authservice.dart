import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      print('AuthService: signing in $email');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Ensure we write a Map<String, dynamic>
      await _firestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set(<String, dynamic>{'uid': userCredential.user!.uid, 'email': email});
      print('AuthService: sign in successful ${userCredential.user!.uid}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('AuthService: sign in error ${e.code} ${e.message}');
      // Rethrow the original FirebaseAuthException so callers can inspect code/message
      throw e;
    } catch (e, st) {
      // Log unexpected errors (including type-cast errors from plugins)
      print('AuthService: unexpected error during signIn: $e');
      print(st.toString());
      // Rethrow so UI can handle it
      rethrow;
    }
  }

  // Register with email and password
  Future<UserCredential> signUpWithEmailPassword(String email, String password) async {
    try {
      print('AuthService: creating user $email');
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set(<String, dynamic>{'uid': userCredential.user!.uid, 'email': email});
      print('AuthService: user created ${userCredential.user!.uid}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('AuthService: sign up error ${e.code} ${e.message}');
      throw e;
    } catch (e, st) {
      print('AuthService: unexpected error during signUp: $e');
      print(st.toString());
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
      final credential = GoogleAuthProvider.credential(
        accessToken: auth?.accessToken,
        idToken: auth?.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      // Persist user info in Firestore if new
      await _firestore.collection('Users').doc(userCredential.user!.uid).set(
        <String, dynamic>{
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'displayName': userCredential.user!.displayName,
          'photoURL': userCredential.user!.photoURL,
        },
        SetOptions(merge: true),
      );
      return userCredential;
    } catch (e, st) {
      print('AuthService: Google sign-in failed: $e');
      print(st.toString());
      rethrow;
    }
  }

  // Sign out (also from Google)
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignInService.signOut();
    } catch (e) {
      print('AuthService: error signing out: $e');
      rethrow;
    }
  }
}
