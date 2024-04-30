import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_sense/components/app_colors.dart';
import 'package:spend_sense/components/utils/utils.dart';
import 'package:spend_sense/components/widgets/blue_bubble.dart';
import 'package:spend_sense/components/widgets/button.dart';
import 'package:spend_sense/components/widgets/text_input_field.dart';
import 'package:spend_sense/components/widgets/white_bubble.dart';
import 'package:spend_sense/view/home_screen.dart';

import 'package:spend_sense/view_model/repositories/auth_repository.dart';
import '../routes/routes_name.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  ColorFilter colorFilter =
      const ColorFilter.mode(AppColors.backgroundColor, BlendMode.srcIn);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Uint8List? image;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  selectImage() async {
    Uint8List im = await Utils().pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      image = im;
    });
  }

  void signupUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthRepository().signupUser(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        file: image!);
    setState(() {
      isLoading = false;
    });
    if (res != 'success') {
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
                top: size.height * 0.01,
                left: size.width * 0.75,
                child: const WhiteBubble()),
            Positioned(
                top: size.height * 0.005,
                left: size.width * -0.28,
                child: const WhiteBubble()),
            Positioned(
              top: size.height * 0.145,
              left: size.width * 0.25,
              child: const WhiteBubble(),
            ),
            Positioned(
                top: size.height * 0.20,
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
                        const EdgeInsets.only(left: 30, top: 20, right: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign up',
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Center(
                            child: Stack(
                              children: [
                                image != null
                                    ? CircleAvatar(
                                        radius: 45,
                                        backgroundImage: MemoryImage(image!),
                                      )
                                    : ClipOval(
                                        child: CircleAvatar(
                                          radius: 45,
                                          backgroundColor: Colors
                                              .white, // Set the background color to match the filter color
                                          child: ColorFiltered(
                                            colorFilter: const ColorFilter.mode(
                                              AppColors
                                                  .backgroundColor, // Replace with the color you want
                                              BlendMode
                                                  .color, // You can use different blend modes
                                            ),
                                            child: Image.asset(
                                                'assets/images/user.png'),
                                          ),
                                        ),
                                      ),
                                Positioned(
                                  bottom: -10,
                                  left: 55,
                                  child: IconButton(
                                    onPressed: () {
                                      selectImage();
                                    },
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      size: 20,
                                      color: AppColors.backgroundColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.045,
                          ),
                          TextInputField(
                              keyboardType: TextInputType.name,
                              controller: usernameController,
                              hintText: 'Create your username'),
                          SizedBox(
                            height: size.height * 0.01,
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
                            height: size.height * 0.055,
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
                                    child: Text('Sign up',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                            onTap: () => signupUser(),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Center(
                              child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.login);
                            },
                            child: Text(
                              'Already have an account? Log in',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          )),
                        ]),
                  ),
                )),
            Positioned(
                top: size.height * 0.90,
                right: size.height * 0.35,
                child: const BlueBubble()),
            Positioned(
                top: size.height * 0.85,
                left: size.height * 0.43,
                child: Container(
                    height: size.height * 0.15,
                    child: ColorFiltered(
                      colorFilter: colorFilter,
                      child: const Opacity(
                        opacity: 0.35,
                        child: Image(
                          image: AssetImage(
                            'assets/images/rename.png',
                          ),
                        ),
                      ),
                    )))
          ]),
        ),
      ),
    );
  }
}
