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