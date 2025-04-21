import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mind_space/Components/textField.dart';
import 'package:http/http.dart' as http;
import 'package:mind_space/services/secure_storage_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _secureStorage = SecureStorageService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var response = await http.post(
        Uri.parse("http://192.168.227.240:3000/login"),
         headers: {
           'Content-Type': 'application/json',
         },
         body: jsonEncode({
           'email': _emailController.text,
           'password': _passwordController.text,
         }),
      );
      
      // Access form data
      final userData = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      if (response.statusCode == 200){
        final responseData = jsonDecode(response.body);
        print(responseData['session']);

        _secureStorage.saveToken(responseData['session']);
        Navigator.pushReplacementNamed(context, '/home');
      }

      print(userData); // Handle the data as needed
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(45, 38, 57, 1),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 150.0),

                  // Welcome Back text
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: const Color.fromARGB(177, 255, 255, 255),
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20.0),
                  // Don't have an account?
                  Row(
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: const Color.fromARGB(177, 255, 255, 255),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          "Sign up.",
                          style: TextStyle(
                            color: const Color.fromARGB(177, 255, 255, 255),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40.0),

                  CustomTextField(
                    placeholder: "Email",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),

                  CustomTextField(
                    placeholder: "Password",
                    controller: _passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20.0),

                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: const Color.fromRGBO(109, 85, 180, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}