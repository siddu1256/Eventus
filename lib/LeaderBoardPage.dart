import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_controller.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF2EA),
        body: FutureBuilder<Map<String, dynamic>>(
          future: AuthController().getUserWithHighestPoints(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final highestFullName = snapshot.data?['fullName'] ?? '';
              final highestPoints = snapshot.data?['points'] ?? 0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Text(
                      "LeaderBoard",
                      style: GoogleFonts.urbanist(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: const Color(0xFF954962),
                        ),
                        height: 100,
                        width: 100,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                highestFullName[0],
                                style: GoogleFonts.urbanist(
                                  fontSize: 70,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 70,
                              child: Image.asset(
                                "assets/trophy.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      highestFullName,
                      style: GoogleFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/pointsimg.png"),
                      SizedBox(width: 10,),
                      Text(
                        highestPoints.toString(),
                        style: GoogleFonts.urbanist(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  _buildOtherUsersContainer(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildUserContainer(String fullName, int points) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
        color: const Color(0xFF954962),
      ),
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Text(
            fullName.isNotEmpty ? fullName[0] : '',
            style: GoogleFonts.urbanist(
              fontSize: 70,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName,
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Image.asset("assets/pointsimg.png"),
                  SizedBox(width: 10),
                  Text(
                    '$points',
                    style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtherUsersContainer() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
            color: Colors.white,
          ),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: AuthController().getAllUsersSortedByPoints(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final users = snapshot.data ?? [];
                return Column(
                  children: users.map((user) {
                    final fullName = user['fullName'];
                    final points = user['Points'];
                    return Container(
                      margin: EdgeInsets.only(top: users.indexOf(user) == 0 ? 0 : 10),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF954962),
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                            ),
                            height: 60,
                            width: 60,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10, left: 20),
                              child: Text(
                                fullName.isNotEmpty ? fullName[0] : '',
                                style: GoogleFonts.urbanist(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    fullName,
                                    style: GoogleFonts.urbanist(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 50),
                                Row(
                                  children: [
                                    Image.asset("assets/pointsimg.png"),
                                    SizedBox(width: 10),
                                    Text(
                                      '$points',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LeaderBoard(),
  ));
}
