// ignore: uri_does_not_exist
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email', 'profile'],
  );

  Future<GoogleSignInAccount?> signIn() async {
    try {
      debugPrint('GoogleSignInService: starting signIn()');
      final account = await _googleSignIn.signIn();
      debugPrint(
        'GoogleSignInService: signIn() completed. account is ${account == null ? 'null (user cancelled)' : account.email}',
      );
      return account;
    } catch (e, st) {
      // Log full details so we can see platform channel exceptions and stack traces
      debugPrint('GoogleSignInService: signIn() error: $e');
      debugPrint(st.toString());
      // Rethrow so callers (AuthService) can continue handling and show the error
      rethrow;
    }
  }

  Future<GoogleSignInAuthentication?> getAuth(
    GoogleSignInAccount account,
  ) async {
    try {
      debugPrint(
        'GoogleSignInService: requesting authentication tokens for ${account.email}',
      );
      final auth = await account.authentication;
      debugPrint(
        'GoogleSignInService: got tokens. idToken present: ${auth.idToken != null}, accessToken present: ${auth.accessToken != null}',
      );
      return auth;
    } catch (e, st) {
      debugPrint('GoogleSignInService: getAuth() error: $e');
      debugPrint(st.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
