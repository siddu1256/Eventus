import 'package:flutter/material.dart';
import 'package:mypart/welcome.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState()=> _SplashState();
}

class _SplashState extends State<Splash> {
  @override
void initState()
  {
    super.initState();
    _navigatetohome();
  }
  
  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds:1500),() {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome()));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body:Container(
        color:const Color(0xFFFBF2EA),
         width: double.infinity,
        child:Column(
           mainAxisAlignment: MainAxisAlignment.center,          
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Container(
                child:Image.asset('assets/logo.png'),
                width:70,
                height:70,
              ),
              SizedBox(width:10),
              Container(
                child:Image.asset('assets/logo2.png'),
                width:100,
                height:100,
              )
           ], ),
          ],
        )
      )
    ),);
  }
}