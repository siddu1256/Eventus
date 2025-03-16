import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypart/CreateEvent.dart';
import 'package:mypart/ManageEvents.dart';
import 'package:mypart/auth_controller.dart';

class EventCreate2 extends StatefulWidget {
  final DateTime dateofEvent;
  final String titleofEvent2;
  final String imageurl2='';
  final String clubName2;
  const EventCreate2({
  Key? key, 
  required this.dateofEvent,
  required this.titleofEvent2,
  required this.clubName2,
}) : super(key: key);
  @override
  
  State<EventCreate2> createState() => _EventCreate2State();
}

class _EventCreate2State extends State<EventCreate2> {
    final AuthController authController = Get.find(); 

  TextEditingController content = TextEditingController();
  TextEditingController speakername = TextEditingController();
  TextEditingController venueplace = TextEditingController();
  TextEditingController hours = TextEditingController();
  TextEditingController minutes = TextEditingController();
  TextEditingController endHours = TextEditingController();
  TextEditingController endMinutes = TextEditingController();
  bool isAMSelected = true;
  bool isEndAMSelected = true;
  bool created = false;

  void selectAM() {
    setState(() {
      isAMSelected = true;
    });
  }

  void selectPM() {
    setState(() {
      isAMSelected = false;
    });
  }

  void selectEndAM() {
    setState(() {
      isEndAMSelected = true;
    });
  }

  void selectEndPM() {
    setState(() {
      isEndAMSelected = false;
    });
  }

  void _createEvent() {
  AuthController authController = Get.find<AuthController>();

    String title = widget.titleofEvent2.toString();
    String clubName = widget.clubName2.toString();
    String dateofEvent = widget.dateofEvent.toString();
    String imageURL = '';
    String startHour = hours.text;
    String startMinutes = minutes.text;
    String endHour = endHours.text;
    String endMinutesValue = endMinutes.text;
    String venue = venueplace.text;
    String speaker = speakername.text;
    String eventContent = content.text;

    authController.uploadEventData(
      title,
      imageURL,
      clubName,
      dateofEvent,
      int.parse(startHour),
      int.parse(startMinutes),
      int.parse(endHour),
      int.parse(endMinutesValue),
      venue,
      speaker,
      eventContent,
      [],
      isAMSelected,
      isEndAMSelected,
    );

    setState(() {
      created = true;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFBF2EA),
        body:Padding(
          padding: const EdgeInsets.only(top:20.0,left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    "Create an Event",
                    style: GoogleFonts.urbanist(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Start Time',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Center(
                      child:Transform.translate(
                        offset: Offset(25, -6),
                      child: TextFormField(
                        controller: hours,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^(1[0-2]|[1-9])$')),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Transform.translate(
                    offset:Offset(0,-10), 
                  child:Text(
                    ":",
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.normal,
                      fontSize: 35,
                    ),
                  ),
              ),
                  SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Center(
                      child:Transform.translate(
                        offset: Offset(25, -6), 
                      child: TextFormField(
                        controller: minutes,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^([0-5][0-9]|[0-9])$')),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: selectAM,
                    child: Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        color: isAMSelected ? Color(0xFF954962) : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "AM",
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: selectPM,
                    child: Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        color: isAMSelected ? Colors.white : Color(0xFF954962),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "PM",
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'End Time',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10), 
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Center(
                      child:Transform.translate(
                        offset:Offset(25,-6),
                      child: TextFormField(
                        controller: endHours,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^(1[0-2]|[1-9])$')),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Transform.translate(
                    offset:Offset(0, -10), 
                  child:Text(
                    ":",
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.normal,
                      fontSize: 35,
                    ),
                  ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Center(
                      child: Transform.translate(
                        offset:Offset(25, -6),
                      child: TextFormField(
                        controller: endMinutes,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^([0-5][0-9]|[0-9])$')),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: selectEndAM,
                    child: Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        color: isEndAMSelected ? Color(0xFF954962) : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "AM",
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: selectEndPM,
                    child: Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        color: isEndAMSelected ? Colors.white : Color(0xFF954962),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "PM",
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Venue",
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                width: 400,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child:Center(
                  child:Transform.translate(
                    offset:Offset(10, -5), 
                child: TextFormField(
                  controller: venueplace,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Speaker",
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                width: 400,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child:Center(
                  child:Transform.translate(
                    offset: Offset(10, -5),
                child: TextFormField(
                  controller: speakername,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                ),
              ),
            ),
              SizedBox(height: 20),
              Text(
                "About Event",
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:10,top:0.1),
                    child: TextFormField(
                      controller: content,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Description",
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
  child: ElevatedButton(
    onPressed: () async {
  if (!created) {
    if (content.text.isEmpty ||
        speakername.text.isEmpty ||
        venueplace.text.isEmpty ||
        hours.text.isEmpty ||
        minutes.text.isEmpty ||
        endHours.text.isEmpty ||
        endMinutes.text.isEmpty) {
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
    } else {
      _createEvent();
      setState(() {
        created = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Eventsmanage()),
      );
    }
  }
},
    
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(created ? "Created" : "Create",
        style: GoogleFonts.urbanist(
          color:Colors.black,
          fontWeight:FontWeight.w700),),
        if (created) Icon(Icons.check),
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


