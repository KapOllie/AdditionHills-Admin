import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("Error during sign-up: ${e.message}");
    } catch (e) {
      print("An unknown error occurred: $e");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      switch (e.code) {
        case "wrong-password":
          throw "The password you entered is incorrect. Please try again.";
        // Add more cases here to handle other specific FirebaseAuthException errors
        default:
          // Re-throw the exception if it's not one of the specific cases handled above
          throw e;
      }
    } catch (e) {
      print("An unknown error occurred: $e");
      // Optionally, you could throw here too if you want to surface non-Firebase errors
      throw e;
    }
  }
}
