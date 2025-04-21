import 'package:flutter/material.dart';
import 'package:mind_space/Components/sign_upbutton.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  
  void SignUserIn(){
    print(email.text);
    print(name.text);
    print(password.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff14141d),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Image.asset("images/signin.png"),
              
              
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome!", style: TextStyle(color: const Color.fromARGB(177, 255, 255, 255), fontSize: 34.0, fontWeight: FontWeight.w500),),
                    Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 45.0, fontWeight: FontWeight.bold),),
                    SizedBox(height: 30.0),
                    Text("E-Mail", style: TextStyle(color: const Color.fromARGB(141, 255, 255, 255), fontSize: 20.0, fontWeight: FontWeight.w500),),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(hintText: "Enter Email", hintStyle: TextStyle(color: const Color.fromARGB(183, 255, 255, 255),),
                      suffixIcon: Icon(Icons.email, color: Colors.white,)
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text("Name", style: TextStyle(color: const Color.fromARGB(141, 255, 255, 255), fontSize: 20.0, fontWeight: FontWeight.w500),),
                    TextField(
                      controller: name,
                      decoration: InputDecoration(hintText: "Enter your name", hintStyle: TextStyle(color: const Color.fromARGB(183, 255, 255, 255),),
                      suffixIcon: Icon(Icons.person, color: Colors.white,)
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text("Password", style: TextStyle(color: const Color.fromARGB(141, 255, 255, 255), fontSize: 20.0, fontWeight: FontWeight.w500),),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(hintText: "Create a password", hintStyle: TextStyle(color: const Color.fromARGB(183, 255, 255, 255),),
                      suffixIcon: Icon(Icons.password, color: Colors.white,)
                      ),
                    ),
                    SizedBox(height: 30.0),
                    
                    Row(
                      children: [
                        MyButton(
                          onTap: SignUserIn,
                        )
                      ],
                    )
                  ],
                ),
              ),
              
              
          ],
        ),
      ),
    );
  }
}