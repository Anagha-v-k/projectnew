import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/screens/petrolpumb/viewreq.dart';
import 'package:vehicleassistant/user/fuel.dart';
import 'package:vehicleassistant/user/rating.dart';

import '../login_page.dart';
import 'addserviceman.dart';

class Phome extends StatelessWidget {
  const Phome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final spref = await SharedPreferences.getInstance();
                spref.clear();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 200),
              // ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Viewreq();
                    }));
                  },
                  child: Text('view request'),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Servman();
                    }));
                  },
                  child: Text('add serviceman'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
