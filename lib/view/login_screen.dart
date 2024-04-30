// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spend_sense/components/app_colors.dart';
import 'package:spend_sense/components/widgets/blue_bubble.dart';
import 'package:spend_sense/components/widgets/button.dart';
import 'package:spend_sense/components/widgets/text_input_field.dart';
import 'package:spend_sense/components/widgets/white_bubble.dart';

import 'package:spend_sense/view_model/repositories/auth_repository.dart';
import '../routes/routes_name.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  ColorFilter colorFilter =
      const ColorFilter.mode(AppColors.backgroundColor, BlendMode.srcIn);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthRepository().loginUser(
        email: emailController.text, password: passwordController.text);

    setState(() {
      isLoading = false;
    });
    if (res == 'success') {
      Navigator.pushReplacement(
          context, RoutesName.bottomNavigation as Route<Object?>);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                AppColors.backgroundColor,
                Color.fromARGB(255, 143, 105, 249)
              ])),
          child: Stack(children: [
            Positioned(
              top: size.height * 0.02,
              left: size.width * 0.65,
              child: const WhiteBubble(),
            ),
            Positioned(
              top: size.height *
                  0.005, // Adjust the top value to position the image as needed
              left: size.width *
                  -0.25, // Adjust the right value to position the image as needed
              child: const WhiteBubble(),
            ),
            Positioned(
                top: size.height *
                    0.19, // Adjust the top value to position the image as needed
                left: size.width *
                    0.25, // Adjust the right value to position the image as needed
                child: const WhiteBubble()),
            Positioned(
                top: size.height * 0.25,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 30, right: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Log in',
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: size.height * 0.075,
                          ),
                          TextInputField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              hintText: 'Enter your email'),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          TextInputField(
                              keyboardType: TextInputType.name,
                              isObscure: true,
                              controller: passwordController,
                              hintText: 'Enter your password'),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Button(
                              child: isLoading
                                  ? const SizedBox(
                                      height: 27,
                                      width: 27,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ) // Show progress indicator
                                  : const Center(
                                      child: Text('Log in',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                              onTap: () => loginUser()),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Center(
                              child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.signup);
                            },
                            child: Text(
                              'Don\'t have an account? Sign up',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          )),
                        ]),
                  ),
                )),
            Positioned(
                top: size.height * 0.85,
                right: size.height * 0.35,
                child: const BlueBubble()),
            Positioned(
                top: size.height * 0.75,
                left: size.height * 0.4,
                child: const BlueBubble())
          ]),
        ),
      ),
    );
  }
}
