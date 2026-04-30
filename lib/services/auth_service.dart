import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    final String? idToken = googleUser.authentication.idToken;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<void> signOutFromGoogle() async {
    await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }

  Future<void> deleteUser() async {
    final googleUser = await GoogleSignIn.instance.authenticate();
    final credential = GoogleAuthProvider.credential(
      idToken: googleUser.authentication.idToken,
    );
    await _auth.currentUser!.reauthenticateWithCredential(credential);
    await _auth.currentUser!.delete();
    await GoogleSignIn.instance.signOut();
  }
}
