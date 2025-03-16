import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:mypart/auth_controller.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypart/homepage.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  AuthController authController = Get.find<AuthController>(); 
  late String? rollNumber; 

  @override
  void initState() {
    super.initState();
    getCurrentUserRollNumber(); 
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF2EA),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Notifications",
                style: GoogleFonts.urbanist(
                  fontSize: 50,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchEventsData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<Map<String, dynamic>> events = snapshot.data!;
                      List<Widget> containers = [];
                      DateTime now = DateTime.now();
                      String formattedDate = DateFormat('yyyy-MM-dd').format(now);

                      events.forEach((event) {
                        if (shouldShowContainer(event, formattedDate)) {
                          containers.add(
                            Container(
                              margin: EdgeInsets.only(bottom: 10.0), 
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.location_on),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(event['venueplace']),
                                  ),],),
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEAEAEA),
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                      child:Center(
                                      child:Text(DateFormat(' d\nMMM').format(event['DateSelected'].toDate())
                                      ),
                                      ),
                                      ),
                                      SizedBox(width: 10,),
                                  Text(
                                event['titleofEvent'], 
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),],)
                              
                              ],),
                            ),
                          );
                        }
                      });

                      if (containers.isNotEmpty) {
                        return ListView(
                          children: containers,
                        );
                      } else {
                        return Center(
                          child: Text(
                            'No Notifications',
                            style: GoogleFonts.urbanist(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      }
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool shouldShowContainer(Map<String, dynamic> event, String formattedDate) {
    List<String> rollNumbers = (event['rollNumbers'] as List<dynamic>).cast<String>();
    Timestamp dateSelectedTimestamp = event['DateSelected'] as Timestamp;
    DateTime dateSelected = dateSelectedTimestamp.toDate();
    String dateSelectedString = DateFormat('yyyy-MM-dd').format(dateSelected);
    return rollNumber != null && rollNumbers.contains(rollNumber) && dateSelectedString == formattedDate;
  }

  Future<List<Map<String, dynamic>>> fetchEventsData() async {
    try {
      List<Map<String, dynamic>> fetchedEvents = await authController.fetchAllEvents();
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      fetchedEvents.removeWhere((event) => event['DateSelected'].toDate() != now);
      return fetchedEvents;
    } catch (error) {
      print('Error fetching events data: $error');
      throw error;
    }
  }

  void getCurrentUserRollNumber() async {
    rollNumber = await authController.getCurrentUserRollNumber();
    setState(() {});
  }
}
