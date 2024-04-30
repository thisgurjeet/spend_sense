// import 'dart:typed_data';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:spend_sense/model/user.dart';

// import 'package:spend_sense/view_model/repositories/auth_repository.dart';

// final userProvider = StateProvider<UserModel?>((ref) => null);

// final authControllerProvider = Provider((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return AuthController(authRepository: authRepository, ref: ref);
// });




// class AuthController {
//   final AuthRepository authRepository;
//   final ProviderRef ref;

//   AuthController({required this.authRepository, required this.ref});

//   Stream<User?> get authStateChange => authRepository.authStateChange;

//   Future<String> userSignInWithEmail(
//       BuildContext context, String email, String password) async {
//     return await authRepository.loginUser(email: email, password: password);
//   }

//   Future<String> userSignUpEmail(BuildContext context, String username,
//       String email, String password, Uint8List file) async {
//     return await authRepository.signupUser(
//         username: username, email: email, password: password, file: file);
//   }

//   Future signOut() async {
//     return await authRepository.signOut();
//   }

//   Stream<UserModel> getUserData(String uid) {
//     return authRepository.getUserData(uid);
//   }
// }
