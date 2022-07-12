import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/user/work.dart';

import '../constants/constant_data.dart';
import '../screens/userhome.dart';
import 'fuel.dart';

class Workreq extends StatelessWidget {
  Workreq({Key? key, required String this.workshopId}) : super(key: key);
  final String workshopId;
  final problemcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final vehicleTypeController = TextEditingController();
  final nameController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  order(BuildContext context) async {
    LocationData loc = await Location.instance.getLocation();
    final spref = await SharedPreferences.getInstance();
    final response =
        await post(Uri.parse(ConstantData.baseUrl + 'addwrequest'), body: {
      'customer': spref.getString('userid'),
      'workshop': workshopId,
      'name': nameController.text,
      'location': '${loc.latitude},${loc.longitude}',
      'status': '0',
      'problem': problemcontroller.text,
      'vehicle_model': vehicleTypeController.text,
      'phone_number': phonecontroller.text,
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'time': '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}',
    });
    final data = jsonDecode(response.body);
    print(data);
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
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
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
                    controller: vehicleTypeController,
                    validator: (value) {},
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('vehicle model'))),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .01),
                child: TextFormField(
                    controller: nameController,
                    validator: (value) {},
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('name'))),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .01),
                child: TextFormField(
                    controller: phonecontroller,
                    validator: (value) {},
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('phone number'))),
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
        ),
      ),
    );
  }
}
