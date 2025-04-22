/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mind_space/Components/textField.dart';
import 'package:http/http.dart' as http;

class SignupNew extends StatefulWidget {
  const SignupNew({super.key});

  @override
  State<SignupNew> createState() => _SignupNewState();
}



class _SignupNewState extends State<SignupNew> {

final _formKey = GlobalKey<FormState>();
  final _NameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _NameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      
      var response = await http
      .post(Uri.parse("http://192.168.225.240:8080/signup"),headers: {
      'Content-Type': 'application/json', // Specify JSON content type
    }, body: jsonEncode({
        'name': _NameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );
      

      // Access form data
      final userData = {
        'name': _NameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      print(userData); // Handle the data as needed
      print(response.body);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //background color
      backgroundColor: const Color.fromRGBO(45, 38, 57, 1),


      // Body
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

              //Create an account
              Text("Create an account", style: TextStyle(color: const Color.fromARGB(177, 255, 255, 255), fontSize: 40.0, fontWeight: FontWeight.bold),),

              SizedBox(height: 20.0),
              //Already have an account?
              Row(
                children: [
                  Text("Already have an account? ", style: TextStyle(color: const Color.fromARGB(177, 255, 255, 255), fontSize: 16.0, fontWeight: FontWeight.w400),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/loginpage');
                    },
                    child: Text("Log in.", style: TextStyle(color: const Color.fromARGB(177, 255, 255, 255), fontSize: 16.0, fontWeight: FontWeight.w400),)),
                ],
              ),

              /*
              TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
              hintText: "Name",
              hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.5),
                  ),
                filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                  ),
              focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
              ),
          
              ),
              )
              */
              SizedBox(height: 20.0),

              CustomTextField(
                  placeholder: "Name",
                  controller: _NameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),

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
                  placeholder: "Enter your password",
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
                  child: const Text('Create an account', style: TextStyle(color: Colors.white),),
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
      )
    );
  }
}
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mind_space/Components/textField.dart';
import 'package:http/http.dart' as http;

class SignupNew extends StatefulWidget {
  const SignupNew({super.key});

  @override
  State<SignupNew> createState() => _SignupNewState();
}

class _SignupNewState extends State<SignupNew> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        var response = await http.post(
          Uri.parse("http://192.168.225.240:8080/signup"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'name': _nameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
          }),
        );
        
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Success
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Account created successfully!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          // Navigate to login page
          Navigator.pushReplacementNamed(context, '/loginpage');
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signup failed. Please try again.'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      } catch (e) {
        print('Error during signup: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network error. Please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF332A42), // Dark purple
              Colors.grey.shade900, // Dark background
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50.0),
                      
                      // Logo or App Icon
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(0xFF6D55B4),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF6D55B4).withOpacity(0.5),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.psychology_alt,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 40.0),

                      // Create an account text with animation
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, (1 - value) * 20),
                              child: child,
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create an account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Join us to start your mind space journey",
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 40.0),

                      // Name Field with animation
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset((1 - value) * 30, 0),
                              child: child,
                            ),
                          );
                        },
                        child: _buildTextField(
                          controller: _nameController,
                          hintText: "Full Name",
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(height: 20.0),

                      // Email Field with animation
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 900),
                        curve: Curves.easeOutCubic,
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset((1 - value) * 30, 0),
                              child: child,
                            ),
                          );
                        },
                        child: _buildTextField(
                          controller: _emailController,
                          hintText: "Email",
                          prefixIcon: Icons.email_outlined,
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
                      ),

                      SizedBox(height: 20.0),

                      // Password Field with animation
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeOutCubic,
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset((1 - value) * 30, 0),
                              child: child,
                            ),
                          );
                        },
                        child: _buildTextField(
                          controller: _passwordController,
                          hintText: "Password",
                          isPassword: !_isPasswordVisible,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey.shade400,
                              size: 20,
                            ),
                          ),
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
                      ),

                      SizedBox(height: 40.0),

                      // Sign up Button with animation
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 1100),
                        curve: Curves.easeOutCubic,
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, (1 - value) * 20),
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF6D55B4).withOpacity(0.3),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitForm,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 56),
                              backgroundColor: const Color(0xFF6D55B4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Create Account',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.0),

                      // Login option
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/loginpage');
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Color(0xFF6D55B4),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required FormFieldValidator<String> validator,
    bool isPassword = false,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade700,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: Colors.grey.shade500,
                  size: 20,
                )
              : null,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        ),
        validator: validator,
      ),
    );
  }
}