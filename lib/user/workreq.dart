import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/user/work.dart';

import '../constants/constant_data.dart';
import '../screens/userhome.dart';
import 'fuel.dart';

class Workreq extends StatelessWidget {
  Workreq({Key? key}) : super(key: key);
  final problemcontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  final formkey = GlobalKey<FormState>();
  order(BuildContext context) async {
    final spref = await SharedPreferences.getInstance();
    final response =
        await post(Uri.parse(ConstantData.baseUrl + 'addwrequest'), body: {
      'customer': spref.getString('userid'),
      // 'workshop': widget.petrolId,
      'problem': problemcontroller.text,
      'phone_number': phonecontroller.text,
    });
    final data = jsonDecode(response.body);
    if (data['result'] != false) {
      Fluttertoast.showToast(msg: 'successfully requested for service!!!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Userhome();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 50, vertical: deviceHeight * .1),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Fuel();
              }));
            },
            leading: Icon(Icons.local_gas_station),
            title: Text('ratings and reviews'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Work();
              }));
            },
            leading: Icon(Icons.build),
            title: Text('order spareparts'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 80, vertical: deviceHeight * .01),
            child: TextFormField(
                controller: problemcontroller,
                validator: (value) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Problem description'))),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 80, vertical: deviceHeight * .01),
            child: TextFormField(
                controller: problemcontroller,
                validator: (value) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('vehicle type'))),
          ),
          ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  order(context);
                }
                // print('tapped');
                // if (formkey.currentState!.validate()) {
                //   order(context);
                // }
              },
              child: Text('post')),
        ]),
      ),
    );
  }
}
