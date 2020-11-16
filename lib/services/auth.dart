import 'package:bookario/components/persistence_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseFirestore.instance;

  Future signUp(
      String name,
      String email,
      String password,
      String confirmPassword,
      String phoneNumber,
      String age,
      String gender,
      String userType) async {
    String _token;
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      print("New user ${user.email} added to firebase");
      user.sendEmailVerification().then((onValue) {
        print("Verification mail sent");
      });
      if (user != null) {
        PersistenceHandler.deleteStore("uid");
        PersistenceHandler.setter("uid", user.uid);
      }
      if (userType == 'Customer') {
        try {
          DocumentReference ref =
              await databaseReference.collection("customers").add({
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'age': age,
            'gender': gender,
            'userType': userType,
            'token': _token
          });
          print(ref.id);
        } catch (e) {
          print(e.toString());
        }
      } else {
        try {
          DocumentReference ref =
              await databaseReference.collection("clubs").add({
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'age': age,
            'gender': gender,
            'userType': userType,
            'token': _token
          });
          print(ref.id);
        } catch (e) {
          print(e.toString());
        }
      }
      return user;
    } catch (e) {
      // setState(() {
      //   loading = false;
      // });
      // CreateToast.showToast(e);
      print(e);
      return null;
    }
  }

  Future login(String email, String password) async {
    await PersistenceHandler.deleteStore("uid");
    await PersistenceHandler.deleteStore("token");
    User user;
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = result.user;
      print(user.uid);
      if (user != null) {
        try {
          await databaseReference
              .collection("customers")
              .doc(user.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              print('Document data: ${documentSnapshot.data()}');
              //   PersistenceHandler.setter("uid", user.uid);
              //   PersistenceHandler.setter("token", f.data());
            } else {
              print('Document does not exist on the database');
            }
          });
          return user;
        } catch (e) {
          print(e);
          // CreateToast.showToast("Error occured. Try after some time.");
        }
      } else {
        // CreateToast.showToast("User does not exist");
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e.code);
      }
    }
  }
}
