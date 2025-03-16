import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypart/auth_controller.dart';
import 'package:mypart/forgotpassword.dart';
import 'package:mypart/homepage.dart';
import 'package:mypart/welcome.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int selectedRatio = 0;
  void setSelectedRatio(int val) {
    setState(() {
      selectedRatio = val;
    });
  }

  bool isSignup = false;
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = Get.put(AuthController());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF2EA),
      resizeToAvoidBottomInset: false, 
      body: SingleChildScrollView( 
        child: Padding(
          padding: EdgeInsets.only(left: 0, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Welcome()),
                  );
                },
                icon: Icon(Icons.arrow_back),
              ),
              SizedBox(height: 90),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Text(
                      "Welcome!",
                      style: GoogleFonts.urbanist(
                        color: Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Please enter your account details to sign in your account',
                      style: GoogleFonts.urbanist(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 180),
              Container(
                padding: EdgeInsets.only(top: 70, bottom: 140),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7CECE),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.zero,
                    top: Radius.circular(80.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 10, right: 10.0),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            labelStyle: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 20.0, right: 10.0),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            labelStyle: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.urbanist(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            authController.signIn(
                                emailController.text, passwordController.text);
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.urbanist(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
