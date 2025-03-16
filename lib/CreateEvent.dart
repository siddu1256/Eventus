import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypart/CreateEvent2.dart';
import 'package:mypart/auth_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCreation extends StatefulWidget {
  const EventCreation({Key? key}) : super(key: key);

  @override
  State<EventCreation> createState() => _EventCreationState();
}

class _EventCreationState extends State<EventCreation> {
  late AuthController authController;
  String imageurl='';
  TextEditingController clubName = TextEditingController();
  TextEditingController titleofEvent = TextEditingController();

  DateTime today = DateTime.now(); 
  File? _image;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  Future<void> _pickImageFromGallery() async {
  final picker = ImagePicker();
  final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    AuthController authController = Get.find<AuthController>();

    String imageURL = await authController.uploadImageToStorage(File(pickedImage.path));

    setState(() {
      _image = File(pickedImage.path);
      imageurl = imageURL; 
    });
    
    Navigator.pop(context);
  }
}

  @override
  void initState() {
    super.initState();
    Get.put(AuthController(), permanent: true);
  }

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
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    Text(
                      "Create Event",
                      style: GoogleFonts.urbanist(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: GoogleFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 450,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Center(
                        child: Transform.translate(
                          offset: Offset(10, -5),
                          child: TextFormField(
                            controller: titleofEvent,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                            style: GoogleFonts.urbanist(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Club",
                      style: GoogleFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 450,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Center(
                        child: Transform.translate(
                          offset: Offset(10, -5),
                          child: TextFormField(
                            controller: clubName,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                            style: GoogleFonts.urbanist(),
                          ),
                        ),
                      ),
                    ),
                     SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date",
                          style: GoogleFonts.urbanist(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            child: TableCalendar(
                              headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
                              availableGestures: AvailableGestures.all,
                              onDaySelected: _onDaySelected,
                              selectedDayPredicate: (day) => isSameDay(day, today),
                              focusedDay: today,
                              firstDay: DateTime.now(),
                              lastDay: DateTime.now().add(Duration(days: 30 * 365)),
                              calendarStyle: CalendarStyle(
                                todayDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                selectedDecoration: BoxDecoration(
                                  color: const Color(0xFF954962),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 70),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
  context, 
  MaterialPageRoute(
    builder: (context) => EventCreate2(
      dateofEvent: today,
      titleofEvent2: titleofEvent.text,
      clubName2:clubName.text,
    ),
  ),
);
                          },
                          child: Text(
                            "Next",
                            style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EventCreation(),
  ));
}
