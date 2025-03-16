import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypart/AdminHomePage.dart';
import 'package:mypart/homepage.dart';
import 'package:mypart/welcome.dart';
import 'package:path/path.dart' as Path;

class AuthController extends GetxController {
  int _failedAttempts = 0;
  Timer? _timeoutTimer;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool result = false;
  var isLoading = false.obs;

  String getCurrentUserID() {
    User? user = auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  Future<String> uploadImageToStorage(File image) async {
    String imageURL = '';
    String Filename = Path.basename(image.path);

    var reference = FirebaseStorage.instance.ref().child('eventImages/$Filename');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      imageURL = value;
    }).catchError((e) {
      print("Error happened $e");
    });
    return imageURL;
  }

  Future<void> uploadEventData(String title, String imageURL, String clubName, String dateofEvent, int startHour, int startMinutes,
      int endHour, int endMinutes, String venueplace, String speakername, String content, List<String> rollNumbers,bool isAMSelected,bool isEndAMSelected) async {
    try {
      DateTime selectedDate = DateTime.parse(dateofEvent);
      Timestamp timestamp = Timestamp.fromDate(selectedDate);
      String userId = getCurrentUserID();

      final conflictingEvents = await checkConflictingEvents(selectedDate, startHour, startMinutes, endHour, endMinutes);
      
      if (conflictingEvents.isNotEmpty) {
        Get.dialog(
          AlertDialog(
            title: Text('Conflicting Event Found'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: conflictingEvents.map((event) {
                return Text('${event['titleofEvent']} - number of registered users:${event['rollNumbers'].length}');
              }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); 
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  _uploadEventData(title, imageURL, clubName, dateofEvent, startHour, startMinutes, endHour, endMinutes, venueplace, speakername, content, rollNumbers, isAMSelected, isEndAMSelected);
                  Get.back(); 
                },
                child: Text('Proceed'),
              ),
            ],
          ),
        );
      } else {
        await _uploadEventData(title, imageURL, clubName, dateofEvent, startHour, startMinutes, endHour, endMinutes, venueplace, speakername, content, rollNumbers, isAMSelected, isEndAMSelected);
      }

      print('Event data uploaded successfully.');
    } catch (error) {
      print('Error uploading event data: $error');
    }
  }

  Future<List<Map<String, dynamic>>> checkConflictingEvents(DateTime selectedDate, int startHour, int startMinutes, int endHour, int endMinutes) async {
    try {
      QuerySnapshot<Map<String, dynamic>> eventsSnapshot = await firestore
          .collection('events')
          .where('DateSelected', isEqualTo: Timestamp.fromDate(selectedDate))
          .where('hours', isEqualTo: startHour)
          .where('minutes', isEqualTo: startMinutes)
          .where('endHours', isEqualTo: endHour)
          .where('endMinutes', isEqualTo: endMinutes)
          .get();

      return eventsSnapshot.docs.map((doc) => doc.data()!).toList();
    } catch (error) {
      print('Error fetching conflicting events: $error');
      return [];
    }
  }

  Future<void> _uploadEventData(String title, String imageURL, String clubName, String dateofEvent, int startHour, int startMinutes,
      int endHour, int endMinutes, String venueplace, String speakername, String content, List<String> rollNumbers,bool isAMSelected,bool isEndAMSelected) async {
    String userId = getCurrentUserID();

    DateTime selectedDate = DateTime.parse(dateofEvent);
    Timestamp timestamp = Timestamp.fromDate(selectedDate);

    await firestore.collection('events').add({
      'userId': userId,
      'titleofEvent': title,
      'imageURL': imageURL,
      'clubName': clubName,
      'DateSelected': timestamp,
      'hours': startHour,
      'minutes': startMinutes,
      'endHours': endHour,
      'endMinutes': endMinutes,
      'venueplace': venueplace,
      'speakername': speakername,
      'content': content,
      'rollNumbers': rollNumbers,
      'isAMSelected': isAMSelected,
      'isEndAMSelected': isEndAMSelected,
    });
  }

  Future<void> signUp(String email, String password, String fullName, String rollNumber, String department) async {
    isLoading(true);
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'Role': 'normal',
        'Points':0,
        'email': email,
        'fullName': fullName,
        'rollNumber': rollNumber,
        'department': department,
      });
      isLoading(false);
      Get.offAll(() => Welcome());
    } catch (error) {
      isLoading(false);
      print("Error in authentication: $error");
    }
  }

  Future<String> getCurrentUserPoints() async {
    String userId = getCurrentUserID();
    if (userId.isNotEmpty) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await firestore.collection('users').doc(userId).get();
        return userDoc.data()!['Points'].toString(); 
      } catch (error) {
        print('Error fetching current user points: $error');
        throw error; 
      }
    }
    throw 'User ID is empty'; 
  }

  Future<void> signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.defaultDialog(
        title: "Alert",
        middleText: "Unfilled email or password",
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('OK', style: GoogleFonts.urbanist(color: Colors.black)),
          ),
        ],
      );
      return;
    }

    isLoading(true);
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _failedAttempts = 0;
      _cancelTimeoutTimer();

      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestore.collection('users').doc(userCredential.user!.uid).get();
      String role = userDoc.data()!['Role'];

      isLoading(false);

      if (role == 'Admin') {
        Get.offAll(() => AdminHomepage());
      } else {
        Get.offAll(() => Homepage());
      }
    } catch (error) {
      isLoading(false);
      print("Error in authentication: $error");

      _failedAttempts++;

      if (_failedAttempts >= 5) {
        _startTimeoutTimer(Duration(minutes: 5));
      Get.defaultDialog(
          title: "Alert",
          middleText: "You have been timed out for 5 minutes due to multiple failed login attempts.",
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
            ),
          ],
        );
      } else {
        Get.defaultDialog(
          title: "Alert",
          middleText: "Incorrect email or password",
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
            ),
          ],
        );
      }
      return;
    }
  }

  void forgetPassword(String email) {
    auth.sendPasswordResetEmail(email: email).then((value) {
      Get.snackbar("Email Sent", "We have sent an email to reset your password");
    }).catchError((e) {
      print("Error in resetting password $e");
    });
  }

  Future<List<Map<String, dynamic>>> fetchEvents(String userId) async {
    try {
      print(userId);
      QuerySnapshot<Map<String, dynamic>> eventsSnapshot = await firestore
          .collection('events')
          .where('userId', isEqualTo: userId)
          .get();

      List<Map<String, dynamic>> events = eventsSnapshot.docs.map((doc) {
        Map<String, dynamic> eventData = doc.data()!;
        eventData['id'] = doc.id;
        return eventData;
      }).toList();

      return events;
    } catch (error) {
      print('Error fetching events: $error');
      throw error;
    }
  }
  
  Future<List<Map<String, dynamic>>> fetchAllEvents() async {
    try {
      QuerySnapshot<Map<String, dynamic>> eventsSnapshot = await firestore
          .collection('events')
          .get();

      List<Map<String, dynamic>> events = eventsSnapshot.docs.map((doc) {
        Map<String, dynamic> eventData = doc.data()!;
        eventData['id'] = doc.id;
        return eventData;
      }).toList();

      return events;
    } catch (error) {
      print('Error fetching events: $error');
      throw error;
    }
  }
  
  Future<String?> getCurrentUserRollNumber() async {
    String userId = getCurrentUserID();
    if (userId.isNotEmpty) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await firestore.collection('users').doc(userId).get();
        return userDoc.data()!['rollNumber'];
      } catch (error) {
        print('Error fetching current user rollNumber: $error');
        return null;
      }
    }
    return null;
  }

  Future<void> registerUserForEvent(String eventId) async {
    String? rollNumber = await getCurrentUserRollNumber();

    if (rollNumber != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> eventDoc = await firestore
            .collection('events')
            .doc(eventId)
            .get();

        List<dynamic>? rollNumbers = eventDoc.data()?['rollNumbers'];

        if (rollNumbers == null || !rollNumbers.contains(rollNumber)) {
          await firestore.collection('events').doc(eventId).update({
            'rollNumbers': FieldValue.arrayUnion([rollNumber]),
          });

          await firestore.collection('users').doc(getCurrentUserID()).update({
            'Points': FieldValue.increment(1),
          });

          print('User registered for the event successfully.');
        } else {
          print('User is already registered for the event.');
        }
      } catch (error) {
        print('Error registering user for event: $error');
      }
    }
  }

  Future<Map<String, dynamic>> getUserWithHighestPoints() async {
    try {
      QuerySnapshot<Map<String, dynamic>> usersSnapshot = await firestore
          .collection('users')
          .orderBy('Points', descending: true)
          .limit(1)
          .get();

      if (usersSnapshot.docs.isNotEmpty) {
        final userData = usersSnapshot.docs.first.data();
        final fullName = userData?['fullName'] ?? '';
        final points = userData?['Points'] ?? 0;
        return {
          'fullName': fullName,
          'points': points,
        };
      } else {
        return {
          'fullName': '',
          'points': 0,
        };
      }
    } catch (error) {
      print('Error fetching user with highest points: $error');
      return {
        'fullName': '',
        'points': 0,
      };
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsersSortedByPoints() async {
    try {
      QuerySnapshot<Map<String, dynamic>> usersSnapshot = await firestore
          .collection('users')
          .orderBy('Points', descending: true)
          .get();

      final List<Map<String, dynamic>> users = usersSnapshot.docs
          .skip(1)
          .map((doc) {
            Map<String, dynamic> userData = doc.data()!;
            userData['id'] = doc.id;
            return userData;
          })
          .toList();

      return users;
    } catch (error) {
      print('Error fetching users sorted by points: $error');
      throw error;
    }
  }

  void _startTimeoutTimer(Duration duration) {
    _timeoutTimer = Timer(duration, _resetFailedAttempts);
  }

  void _cancelTimeoutTimer() {
    _timeoutTimer?.cancel();
    _timeoutTimer = null;
  }

  void _resetFailedAttempts() {
    _failedAttempts = 0;
  }
}
