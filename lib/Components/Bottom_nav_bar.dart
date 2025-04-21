import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mind_space/Controller/bottom_nav_bar_controller.dart';
import 'package:mind_space/pages/home.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});
  

  @override
  Widget build(BuildContext context) {

    BottomNavBarController controller = Get.put(BottomNavBarController());

    return Scaffold(
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 14, 13, 13),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor:  Color.fromARGB(255, 14, 13, 13),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(16),
            gap: 8,
            onTabChange: (value) {
              print(value);
              controller.index.value = value;
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.link,
                text: 'feedback',
                ),
              GButton(
                icon: Icons.settings,
                text: 'settings',
                ),
            ],
          ),
        ),
      ),
      body: controller.pages[controller.index.value],
    );
  }
}