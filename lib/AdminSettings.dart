import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypart/AdminHomePage.dart';
import 'package:mypart/AdminprofilePage.dart';
import 'package:mypart/EditProfile.dart';
import 'package:mypart/LeaderBoardPage.dart';
import 'package:mypart/homepage.dart';
import 'package:mypart/profile.dart';
import 'package:mypart/welcome.dart';
import 'package:get/get.dart';


class AdminSettingspage extends StatefulWidget {
  const AdminSettingspage({Key? key});

  @override
  State<AdminSettingspage> createState() => _SettingsState();
}

class _SettingsState extends State<AdminSettingspage> {
  bool notificationEnabled= false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF2EA),
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Settings",
                style: GoogleFonts.urbanist(
                  fontSize: 70,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 370,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(Icons.account_circle_sharp,size: 30,),
                              SizedBox(width: 10),
                              Text(
                                "Edit Profile",
                                style: GoogleFonts.urbanist(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.rotate(
                          angle: 3.14, 
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()),);
                            },
                            icon: Icon(Icons.arrow_back_ios_rounded,size: 30,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 80,
                    width: 370,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(Icons.notifications,size: 30,),
                              SizedBox(width: 10),
                              Text(
                                "Notification",
                                style: GoogleFonts.urbanist(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(value: notificationEnabled, onChanged: (value){
                          setState(() {
                            notificationEnabled=value;
                          });
                        },activeColor: const Color(0xFFE7CECE),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 80,
                    width: 370,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(Icons.leaderboard_rounded,size: 30,),
                              SizedBox(width: 10),
                              Text(
                                "LeaderBoard",
                                style: GoogleFonts.urbanist(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.rotate(
                          angle: 3.14, 
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaderBoard()));
                            },
                            icon: Icon(Icons.arrow_back_ios_rounded,size: 30,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 80,
                    width: 370,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(Icons.logout,size: 30, ),
                              SizedBox(width: 10),
                              Text(
                                "Log Out",
                                style: GoogleFonts.urbanist(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.rotate(
                          angle: 3.14, 
                          child: IconButton(
                            onPressed: () {
                              Get.offAll(Welcome());
                            },
                            icon: Icon(Icons.arrow_back_ios_rounded,size: 30,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 90),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 70,
                  width: 220,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> AdminHomepage()),);
                        },
                        icon: Icon(Icons.home,size: 30,),
                        color: const Color(0xFF954962),
                      ),
                      SizedBox(width: 32),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> AdminProfile()),);
                        },
                        icon: Icon(Icons.account_circle,size: 30,),
                        color: const Color(0xFF954962),
                      ),
                      SizedBox(width: 32),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.settings,size: 30,),
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
