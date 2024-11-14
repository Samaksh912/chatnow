import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //getting the current user
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  // Sign in
  Future<UserCredential> signinemailpass(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      //save user info if doesnt already exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        },
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code); // FirebaseAuthException will provide error details
    }
  }

  // Sign out
  Future<void> signout() async {
    return await _auth.signOut();
  }

  // Sign up
  Future<UserCredential> signupemailpass(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //save user info in seperate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
         'uid': userCredential.user!.uid,
          'email': email,
        },
      );

      return userCredential; // Return the UserCredential after sign-up
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code); // Handle FirebaseAuthException and show error code
    }
  }
}
