import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypart/AdminHomePage.dart';
import 'package:mypart/AdminSettings.dart';
import 'package:mypart/auth_controller.dart';
import 'package:get/get.dart';
import 'package:mypart/homepage.dart';
import 'package:mypart/settings.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _ProfileState();
}

class _ProfileState extends State<AdminProfile> {
  final AuthController authController = Get.find(); 

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    String userID = authController.getCurrentUserID();
    try {
      DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance.collection('users').doc(userID).get();

      nameController.text = userData['fullName'] ?? '';
      emailController.text = userData['email'] ?? '';
      rollNoController.text = userData['rollNumber'] ?? '';
      departmentController.text = userData['department'] ?? '';
    } catch (error) {
      print("Error fetching user data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF2EA),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Profile",
                style: GoogleFonts.urbanist(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/profilepic.png', 
                width: 150, 
                height: 150, 
                fit: BoxFit.cover,
              ),
              SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name:',
                    style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child:Transform.translate(offset: const Offset(0, 0),child:TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: nameController,
                    enabled: false,
                    style: TextStyle(fontWeight: FontWeight.w500), 
                  ),), ),
                  SizedBox(height: 30),
                  const Text(
                    'Email:',
                    style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child:Transform.translate(offset: Offset(0, 0),child:TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: emailController,
                    enabled: false,
                    style: TextStyle(fontWeight: FontWeight.w500), 
                  ),), ),
                  SizedBox(height: 30),
                  Text(
                    'Roll No:',
                    style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child:Transform.translate(offset: Offset(0, 0),child:TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: rollNoController,
                    enabled: false,
                    style: TextStyle(fontWeight: FontWeight.w500), 
                  ),), ),
                  SizedBox(height: 30),
                  Text(
                    'Department:',
                    style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child:Transform.translate(offset: Offset(0, 0),child:TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: departmentController,
                    enabled: false,
                    style: TextStyle(fontWeight: FontWeight.w500), 
                  ),), ),
                  
                ],
              ),
              SizedBox(height: 60),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 60,
                  width: 220,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> AdminHomepage()),);
                        },
                        icon: Icon(Icons.home,size: 25,),
                        color: const Color(0xFF954962),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.account_circle,size: 25),
                        color: const Color(0xFF954962),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> AdminSettingspage()),);
                        },
                        icon: Icon(Icons.settings,size: 25),
                        color: const Color(0xFF954962),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
