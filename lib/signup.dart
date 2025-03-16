import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypart/auth_controller.dart';
import 'package:mypart/welcome.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF2EA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Welcome()),
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Get Started",
              style: GoogleFonts.urbanist(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Please enter your details to create an account",
              style: GoogleFonts.urbanist(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 32),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFFE7CECE),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 45),
                    buildInputField("Full Name", fullNameController),
                    buildInputField("Email", emailController),
                    buildInputField("Roll No", rollNumberController),
                    buildInputField("Department", departmentController),
                    buildInputField("Create Password", passwordController),
                    buildInputField(
                        "Confirm Password", confirmPasswordController),
                    SizedBox(height: 11),
                    ElevatedButton(
                      onPressed: () {
                        if (emailController.text.isEmpty ||
                            fullNameController.text.isEmpty ||
                            rollNumberController.text.isEmpty ||
                            departmentController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Alert"),
                                content:
                                    Text("Please fill in all the information"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (passwordController.text.length < 6) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content:
                                    Text("Password length should be at least 6 characters."),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        else if (confirmPasswordController.text != passwordController.text){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content:
                                    Text("Confirm password should be same as Password"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                         else {
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();
                          String fullName = fullNameController.text.trim();
                          String rollNumber =
                              rollNumberController.text.trim();
                          String department =
                              departmentController.text.trim();

                          authController.signUp(
                            email,
                            password,
                            fullName,
                            rollNumber,
                            department,
                          );
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.urbanist(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
