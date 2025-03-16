import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypart/auth_controller.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

      setState(() {
        nameController.text = userData['fullName'] ?? '';
        emailController.text = userData['email'] ?? '';
        rollNoController.text = userData['rollNumber'] ?? '';
        departmentController.text = userData['department'] ?? '';
      });
    } catch (error) {
      print("Error fetching user data: $error");
    }
  }

  Future<void> updateUserData() async {
    String userID = authController.getCurrentUserID();
    try {
      await FirebaseFirestore.instance.collection('users').doc(userID).update({
        'fullName': nameController.text,
        'email': emailController.text,
        'rollNumber': rollNoController.text,
        'department': departmentController.text,
      });
      print("User data updated successfully!");
    } catch (error) {
      print("Error updating user data: $error");
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF2EA),
        resizeToAvoidBottomInset: false, 
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),
              Text(
                "Edit Profile",
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
              SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name:',
                    style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),
                  ),
                  Container(
                    height: 40,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  child:TextFormField(
                    decoration: InputDecoration(border: InputBorder.none),
                    controller: nameController,
                    style: GoogleFonts.urbanist(fontWeight: FontWeight.w700),
                    onChanged: (value) => setState(() {}),
                  ),), 
                  SizedBox(height: 50),
                  Text(
                    'Roll No:',
                    style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),
                  ),
                  Container(
                    height: 40,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  child:TextFormField(
                    controller: rollNoController,
                    decoration: InputDecoration(border: InputBorder.none),
                    style: TextStyle(fontWeight: FontWeight.w700),
                    onChanged: (value) => setState(() {}), 
                  ),),
                  SizedBox(height: 50),
                  Text(
                    'Department:',
                    style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),
                  ),
                  Container(
                    height: 40,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  child:TextFormField(
                    controller: departmentController,
                    decoration: InputDecoration(border: InputBorder.none),
                    style: TextStyle(fontWeight: FontWeight.w700),
                    onChanged: (value) => setState(() {}),
                  ),),
                ],
              ),
              SizedBox(height: 90),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      rollNoController.text.isNotEmpty &&
                      departmentController.text.isNotEmpty) {
                    updateUserData();
                    Navigator.pop(context);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Alert"),
                          content: Text("Please fill in all the information"),
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
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
