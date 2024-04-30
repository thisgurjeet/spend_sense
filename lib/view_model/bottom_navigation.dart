import 'package:flutter/material.dart';
import '../components/utils/constants.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        child: BottomNavigationBar(
          onTap: (idx) {
            setState(() {
              pageIdx = idx;
            });
          },
          currentIndex: pageIdx,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: const Color.fromARGB(255, 92, 59, 209),
          unselectedItemColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 174, 178, 255),
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 160, 163, 253),
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.graphic_eq_sharp,
                size: 30,
              ),
              label: 'Chart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 30,
              ),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                size: 30,
              ),
              label: 'Chat',
            ),
          ],
        ),
      ),
      body: pages[pageIdx],
    );
  }
}
