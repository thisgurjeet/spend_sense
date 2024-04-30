import 'package:flutter/material.dart';
import 'package:spend_sense/routes/routes_name.dart';
import 'package:spend_sense/view/home_screen.dart';
import 'package:spend_sense/view/login_screen.dart';
import 'package:spend_sense/view/signup_screen.dart';
import 'package:spend_sense/view_model/bottom_navigation.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupScreen());

      case RoutesName.bottomNavigation:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BottomNavigation());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text('No Routes')),
          );
        });
    }
  }
}
