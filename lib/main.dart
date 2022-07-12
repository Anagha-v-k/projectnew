import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/screens/login_page.dart';
import 'package:vehicleassistant/screens/petrolpumb/petrolhome.dart';
import 'package:vehicleassistant/screens/userhome.dart';
import 'package:vehicleassistant/screens/workshop/whome.dart';

void main() {
  runApp(const MyApp());
}

var userId;
var userType;
getUserId() async {
  final sh = await SharedPreferences.getInstance();
  // sh.setString('userid', '8');
  // sh.setString('type', 'workshop');
  userId = sh.getString('userid');
  userType = sh.getString('type');
  print('going to $userType');
  // sh.setString('type', 'workshop');
  // sh.setString('userid', '2');
  return userId;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: getUserId(),
          builder: (context, snapshot) {
            if (userId == null) {
              return LoginPage();
            } else {
              if (userType == 'user') {
                return Userhome();
              } else if (userType == 'workshop') {
                return Whome();
              } else if (userType == 'petrol pumb') {
                return Phome();
              } else {
                return LoginPage();
              }
            }
          }),
    );
  }
}
