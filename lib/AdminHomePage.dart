import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mypart/AdminSettings.dart';
import 'package:mypart/AdminprofilePage.dart';
import 'package:mypart/LeaderBoardPage.dart';
import 'package:mypart/ManageEvents.dart';
import 'package:mypart/notifications.dart';
import 'package:mypart/regpage.dart';
import 'package:mypart/settings.dart';
import 'auth_controller.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  State<AdminHomepage> createState() => _HomepageState();
}

class _HomepageState extends State<AdminHomepage> {
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    Get.put(AuthController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF2EA),
        body: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7CECE),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: FutureBuilder<String>(
                    future: _authController.getCurrentUserPoints(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        String points = snapshot.data ?? '0'; 
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/pointsimg.png',
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaderBoard()));
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: Colors.white,
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(points),
                                    ), 
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.search),
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search...',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 100,),
                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationsPage()));
                                }, icon: Icon(Icons.notifications,size: 30))
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "Upcoming Events",
                      style: GoogleFonts.urbanist(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 70,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>Eventsmanage()));
                      },
                      child: Text("Manage Events",
                        style: GoogleFonts.urbanist(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child:Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _authController.fetchAllEvents(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        List<Map<String, dynamic>> events = snapshot.data ?? [];
                        events = events.where((event) {
                          DateTime eventDate = event['DateSelected'].toDate();
                          return !eventDate.isBefore(DateTime.now());
                        }).toList();

                        return ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => REG(eventData: events[index]), 
                                  ),
                                );
                              },
                              child: Container(
                                height: 150,
                                width: 10,
                                margin: EdgeInsets.only(bottom: 25),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(events[index]['clubName'],
                                        style: GoogleFonts.urbanist(
                                          fontWeight:FontWeight.w500,
                                        ),),
                                        Spacer(),
                                        Text(
                                          DateFormat(' dd\nMMMM').format(events[index]['DateSelected'].toDate()),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Text(events[index]['titleofEvent'],
                                    style: GoogleFonts.urbanist(
                                      fontSize:30,
                                    ),),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.location_on),
                                        Text(events[index]['venueplace'],
                                        style: GoogleFonts.urbanist(
                                          fontSize:15,
                                          color:Colors.grey,
                                        ),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                        onPressed: () {},
                        icon: Icon(Icons.home,size: 30,),
                        color: const Color(0xFF954962),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProfile()));
                        },
                        icon: Icon(Icons.account_circle,size: 30,),
                        color: const Color(0xFF954962),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminSettingspage()));
                        },
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

void main() {
  runApp(MaterialApp(
    home: AdminHomepage(),
  ));
}
