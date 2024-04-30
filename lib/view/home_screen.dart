import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spend_sense/components/app_colors.dart';
import 'package:spend_sense/model/user.dart';
import 'package:spend_sense/view_model/firebase_data_repository.dart';
import 'package:spend_sense/view_model/provider/user_provider.dart';
import 'package:spend_sense/view_model/repositories/auth_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseDataRepository dataRepository = FirebaseDataRepository();
  double totalAmount = 0;

  @override
  void initState() {
    super.initState();
    // Fetch user details when the screen is initialized
    Provider.of<UserProvider>(context, listen: false).fetchUserDetails();
    getAmount();
  }

  Future<void> getAmount() async {
    double amount = await dataRepository
        .getTotalAmount(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      totalAmount = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserProvider>(context).getUser;
    final size = MediaQuery.of(context).size;
    double limitAmount = 5000;
    double remainingAmount = limitAmount - totalAmount;
    final remainingPercentage =
        remainingAmount.toDouble() / limitAmount.toDouble();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Spend Sense',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              AuthRepository().signOut();
            },
          )
        ],
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 125, 131, 246),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 125, 131, 246),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.username ?? '',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors
                          .transparent, // make the background transparent to see the image
                      child: ClipOval(
                        child: Image.network(
                          user?.photoUrl ?? '',
                          fit: BoxFit
                              .cover, // fit the image inside the CircleAvatar
                          width:
                              80, // set the width to ensure the image is fully visible
                          height:
                              80, // set the height to ensure the image is fully visible
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Log out',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 79, 87, 249),
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                AuthRepository().signOut();
              },
              trailing: const Icon(
                Icons.logout_sharp,
                color: AppColors.backgroundColor,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: AppColors.backgroundColor
                      .withOpacity(0.5), // Shadow color
                  spreadRadius: 1.5, // Spread radius
                  blurRadius: 1.5, // Blur radius
                  offset: const Offset(0, 1), // Offset
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              width: size.width * 0.7,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(children: [
                  Text(
                    remainingAmount > 0
                        ? 'You\'re within the budget'
                        : 'You\'re exceeding budget',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 125, 132, 254),
                        fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.circle,
                    color: remainingAmount > 0 ? Colors.green : Colors.red,
                  )
                ]),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          // a circle to show

          Stack(
            children: [
              Container(
                height: size.height * 0.42,
                width: size.width * 0.75,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 127, 133, 254)
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: size.width * 0.045,
                top: size.height * 0.022,
                child: SizedBox(
                  height: size.height * 0.38,
                  width: size.width * 0.65,
                  child: Stack(
                    children: [
                      // Outer white circle with shadow

                      Container(
                        height: size.height * 0.38,
                        width: size.width * 0.7,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),

                      // Purple countdown line
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: CustomPaint(
                          size: Size(size.height * 0.33, size.width * 0.6),
                          painter: CirclePainter(remainingPercentage),
                        ),
                      ),
                      // Text for remaining days
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              'Remaining',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: AppColors.backgroundColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            Text('\$$remainingAmount',
                                style: GoogleFonts.workSans(
                                    fontSize: 39,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 74, 81, 211))),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            const Text(
                              'BALANCE',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: AppColors.backgroundColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.backgroundColor
                          .withOpacity(0.5), // Shadow color
                      spreadRadius: 1.5, // Spread radius
                      blurRadius: 1.5, // Blur radius
                      offset: const Offset(0, 1), // Offset
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20)),
              width: double.infinity,
              child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Text(
                        'Your Weekly Expnese Budget:',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(child: Container()),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: size.width * 0.15,
                        height: 45,
                        child: Center(
                          child: Text(
                            '\$5000',
                            style: TextStyle(
                                fontSize: 17,
                                color: AppColors.backgroundColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double remainingPercentage;

  CirclePainter(this.remainingPercentage);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.blackColor
      ..strokeWidth = 4.5
      ..style = PaintingStyle.stroke;

    final double radius = size.width * 0.50;
    final double centerX = size.width * 0.50;
    final double centerY = size.height * 0.50;

    const double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * remainingPercentage;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
