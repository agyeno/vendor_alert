import 'package:flutter/material.dart';
import 'package:vendor_alert/app/SplashScreen.dart';


// APP entry point
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
          primarySwatch: Colors.orange
      ),
      home: SplashScreen(),
    );

  }




}




