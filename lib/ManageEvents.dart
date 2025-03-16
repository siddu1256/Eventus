import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypart/AdminHomePage.dart';
import 'package:mypart/CreateEvent.dart';
import 'package:mypart/auth_controller.dart';

class Eventsmanage extends StatefulWidget {
  const Eventsmanage({Key? key});

  @override
  State<Eventsmanage> createState() => _EventsmanageState();
}

class _EventsmanageState extends State<Eventsmanage> {
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF2EA),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHomepage())); 
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Manage Events",
                      style: GoogleFonts.urbanist(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 45, width: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Your Events",
                      style: GoogleFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 100),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventCreation()),
                        );
                      },
                      child: Text(
                        "Create Event",
                        style: GoogleFonts.urbanist(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      
                    ),
                    Icon(Icons.arrow_circle_right_sharp)
                  ],
                ),
                SizedBox(height: 30),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _authController.fetchEvents(_authController.getCurrentUserID()),                
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()); 
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); 
                    } else {
                      List<Map<String, dynamic>> events = snapshot.data ?? [];
                      if (events.isEmpty) {
                        return Center(
                          child: Text(
                            "You have not created any events",
                            style: GoogleFonts.urbanist(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: events.map((event) {
                          DateTime date = event['DateSelected'].toDate();
                          String formattedDate = DateFormat('dd MMMM yyyy').format(date);
                          
                          return Center(
                            child: Container(
                              height: 150,
                              width: 400,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 242, 241, 241),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Transform.translate(
                                offset: Offset(10,10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(children:[
                                      Text("Title: ",style: GoogleFonts.urbanist(
                                        fontSize:20,
                                      ),),
                                      Text(event['titleofEvent'])]),
                                    SizedBox(height: 3,),
                                    Row(children:[
                                      Text("Date:",style: GoogleFonts.urbanist(
                                        fontSize:20,
                                      ),),
                                      Text(formattedDate)]),
                                    SizedBox(height: 3,),
                                    Row(children:[
                                      Text("Club:",style: GoogleFonts.urbanist(
                                        fontSize:20,
                                      ),),
                                      Text(event['clubName'])]),
                                    SizedBox(height: 3,),
                                    Row(children:[
                                      Text("Place:",style: GoogleFonts.urbanist(
                                        fontSize:20,
                                      ),),
                                      Text(event['venueplace'])]),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
