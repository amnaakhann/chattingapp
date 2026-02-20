// ignore: uri_does_not_exist
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  Future<GoogleSignInAccount?> signIn() async {
    try {
      print('GoogleSignInService: starting signIn()');
      final account = await _googleSignIn.signIn();
      print('GoogleSignInService: signIn() completed. account is ${account == null ? 'null (user cancelled)' : account.email}');
      return account;
    } catch (e, st) {
      // Log full details so we can see platform channel exceptions and stack traces
      print('GoogleSignInService: signIn() error: $e');
      print(st.toString());
      // Rethrow so callers (AuthService) can continue handling and show the error
      rethrow;
    }
  }

  Future<GoogleSignInAuthentication?> getAuth(GoogleSignInAccount account) async {
    try {
      print('GoogleSignInService: requesting authentication tokens for ${account.email}');
      final auth = await account.authentication;
      print('GoogleSignInService: got tokens. idToken present: ${auth.idToken != null}, accessToken present: ${auth.accessToken != null}');
      return auth;
    } catch (e, st) {
      print('GoogleSignInService: getAuth() error: $e');
      print(st.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
