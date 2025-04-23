import 'package:flutter/material.dart';
import 'package:mind_space/Components/Bottom_nav_bar.dart';
import 'package:mind_space/pages/addMood.dart';
import 'package:mind_space/pages/home.dart';
import 'package:mind_space/pages/login.dart';
import 'package:mind_space/pages/signup_new.dart';
import 'package:mind_space/services/secure_storage_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
      //home: Home(),
      routes: {
        '/addMood': (context) => const Addmood(),
        '/loginpage': (context) => const LoginPage(),
        '/signup': (context) => const SignupNew(),
        '/home': (context) => Home(),
        '/bottomnav': (context) => const BottomNavBar(),
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final SecureStorageService _storageService = SecureStorageService();
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final loggedIn = await _storageService.isLoggedIn();
    setState(() {
      isLoggedIn = loggedIn;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return isLoggedIn ? BottomNavBar() : const LoginPage();
  }
}
