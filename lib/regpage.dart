import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypart/homepage.dart';
import 'package:mypart/auth_controller.dart'; 
import 'package:intl/intl.dart';
class REG extends StatefulWidget {
  final Map<String, dynamic> eventData;

  const REG({Key? key, required this.eventData}) : super(key: key);

  @override
  State<REG> createState() => _REGState();
}

class _REGState extends State<REG> {
  bool _isRegistered = false;
  
  @override
  void initState() {
    super.initState();
    checkUserRegistration();
  }
  Future<void> checkUserRegistration() async {
    String? rollNumber = await AuthController().getCurrentUserRollNumber();
    if (rollNumber != null) {
      if (widget.eventData['rollNumbers'].contains(rollNumber)) {
        setState(() {
          _isRegistered = true;
        });
      }
    }
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF2EA),
        body: Stack(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child:IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                      );
                    },
                    icon: Icon(Icons.arrow_back,size: 30),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
  fit: BoxFit.scaleDown,
  child: Text(
    widget.eventData['titleofEvent'],
    style: GoogleFonts.urbanist(fontSize: 50, fontWeight: FontWeight.w500),
  ),
),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Icon(Icons.calendar_month,size: 30,color: const Color(0xFF954962),),
                            SizedBox(width: 10),
                            Text(
                              DateFormat('dd MMMM yyyy').format(widget.eventData['DateSelected'].toDate()),
                              style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                           Icon(Icons.access_time,size: 30,color: const Color(0xFF954962),),
                           SizedBox(width: 10,),
                           Text(
                              widget.eventData['hours'].toString(),
                              style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text(":",style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),),
                              Text(
                                widget.eventData['minutes'].toString().length == 1
    ? '0${widget.eventData['minutes']}'
    : widget.eventData['minutes'].toString(),
                              style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text(
      widget.eventData['isAMSelected'] ? " AM" : " PM",
      style: GoogleFonts.urbanist(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    Text("-",style:GoogleFonts.urbanist(
      fontSize:20,
      fontWeight:FontWeight.w900,
    ),),
    Text(
                              widget.eventData['endHours'].toString(),
                              style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text(":",style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),),
                              Text(
                                widget.eventData['endMinutes'].toString().length == 1
    ? '0${widget.eventData['minutes']}'
    : widget.eventData['minutes'].toString(),
                              style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text(
      widget.eventData['isEndAMSelected'] ? " AM" : " PM",
      style: GoogleFonts.urbanist(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Icon(Icons.location_on,size: 30,color: const Color(0xFF954962),),
                            SizedBox(width: 10),
                            Text(
                              widget.eventData['venueplace'],
                              style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.mic,size: 30,color: const Color(0xFF954962),),
                            SizedBox(width: 10),
                            Text(
                              widget.eventData['speakername'],
                              style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Padding(padding: const EdgeInsets.only(left: 10),
                            child:Text(
                              "About Event",
                              style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
  children: [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, 
          child: Container(
            width: double.infinity, 
            child: Text(
              widget.eventData['content'],
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    ),
  ],
),

                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Center(
                child: ElevatedButton(
                  onPressed: _isRegistered
                      ? null 
                      : () async {
                        
                          String? rollNumber = await AuthController().getCurrentUserRollNumber();
                          if (rollNumber != null) {
                            AuthController().registerUserForEvent(widget.eventData['id']);
                            setState(() {
                              _isRegistered = true;
                            });
                          }
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_isRegistered ? "Registered" : "Register"),
                      if (_isRegistered) Icon(Icons.check),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
