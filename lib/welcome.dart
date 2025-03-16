import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypart/loginpage.dart';
import 'package:mypart/signup.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF2EA),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 107, left: 17),
                  child: Image.asset('assets/logo.png'),
                  width: 108,
                  height: 113,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 107, left: 17),
                  child: Image.asset('assets/logo2.png'),
                  width: 200,
                  height: 131,
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            // Welcome Section
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: const Color(0xFFE7CECE),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(80),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 55, left: 42),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Welcome",
                        style: GoogleFonts.urbanist(
                          color: const Color(0xFF1E1E24),
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 70, 
                    child: MaterialButton(
                      minWidth: 350,
                      color: const Color(0xFF1e1e24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.urbanist(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Sign Up Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      color: Color.fromARGB(255, 255, 255, 255),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.urbanist(
                          color: Color.fromARGB(255, 5, 5, 5),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
