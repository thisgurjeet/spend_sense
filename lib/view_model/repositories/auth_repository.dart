import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:spend_sense/model/user.dart' as model;

import 'package:spend_sense/model/user.dart';

import 'package:spend_sense/view_model/storage_model.dart';

class AuthRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<model.UserModel> getUserDetails() async {
    User currentUser = auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(currentUser.uid).get();

    return model.UserModel.fromSnap(documentSnapshot);
  }

  // signing up the user
  Future<String> signupUser({
    required String username,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

// photoUrl, function is created in Storage Modelau
        String photoUrl =
            await StorageModel().uploadImageToStorage('profilePics', file);

        // adding user in our database
        UserModel user = model.UserModel(
            uid: cred.user!.uid,
            photoUrl: photoUrl,
            username: username,
            email: email,
            limit: 0);

        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = 'success';
      } else {
        res = 'Please enter all the details';
      }
    } catch (e) {
      e.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  // signout the user
  Future<void> signOut() async {
    await auth.signOut();
  }

  // get user details
}
