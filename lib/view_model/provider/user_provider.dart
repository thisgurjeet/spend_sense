import 'package:flutter/foundation.dart';
import 'package:spend_sense/model/user.dart';
import 'package:spend_sense/view_model/repositories/auth_repository.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  final AuthRepository _authMethods = AuthRepository();

  UserModel? get getUser => _user;

  // Fetch user details and update the user state
  Future<void> fetchUserDetails() async {
    _user = await _authMethods.getUserDetails();
    notifyListeners();
  }
}
