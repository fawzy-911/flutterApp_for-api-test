import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'Ml Model.dart';
 class SplashScreen extends StatefulWidget
 {
  @override
  State<SplashScreen> createState()=>_SplashScreen();


 }
 class _SplashScreen extends State<SplashScreen> {
   var _time;
   start()
   {
     _time=Timer(Duration(seconds: 6), call);
   }
   void call()
   {
     Navigator.pushReplacement(context,
         MaterialPageRoute(builder: (context)=>MlModel(),),
     );
   }
   @override
   void initState()
   {
     start();
     super.initState();
   }
   @override
   void dispose()
   {
     _time.cancel();
     super.dispose();
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Color(0xffe9f3e8),
       appBar: AppBar(
         systemOverlayStyle: SystemUiOverlayStyle(
             statusBarBrightness: Brightness.dark,
             statusBarColor: Colors.black,
             systemNavigationBarColor: Colors.black
         ),
         backgroundColor: Color(0xffe9f3e8),
         elevation: 0,

       ),
       body: Center(child:Lottie.network('https://lottie.host/737001f0-42c1-4d58-ac9b-550cea0ce7b9/5dpraDth0G.json')),
     );
   }
 }