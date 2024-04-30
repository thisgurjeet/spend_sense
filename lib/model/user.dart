import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String photoUrl;
  final String username;
  final String email;
  final double limit;

  UserModel(
      {required this.uid,
      required this.photoUrl,
      required this.username,
      required this.email,
      required this.limit});

  set state(state) {}

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        uid: snapshot["uid"] ?? '',
        photoUrl: snapshot["photoUrl"] ?? '',
        username: snapshot["username"] ?? '',
        email: snapshot["email"] ?? '',
        limit: snapshot["limit"]);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      limit: map['limit'],
    );
  }
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "photoUrl": photoUrl,
        "username": username,
        "email": email,
      };

  static fromFirebaseUser(User user) {}
}
