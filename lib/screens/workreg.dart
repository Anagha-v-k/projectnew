import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:vehicleassistant/screens/login_page.dart';
import 'package:vehicleassistant/screens/workshop/whome.dart';

import '../Models/authority_model.dart';
import '../constants/constant_data.dart';
import 'petrolpumb/petrolhome.dart';

class WrkReg extends StatefulWidget {
  WrkReg({Key? key}) : super(key: key);

  @override
  State<WrkReg> createState() => _WrkRegState();
}

class _WrkRegState extends State<WrkReg> {
  final usernamecontroller = TextEditingController();
  final licencecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confpasswordcontroller = TextEditingController();
  final workshopnamecontroller = TextEditingController();
  final ownernamecontroller = TextEditingController();
  final districtcontroller = TextEditingController();
  final authtypecontroller = TextEditingController();
  final authnamecontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  gps() async {
    print('object');
    var loc = await Location.instance.getLocation();
    print(loc.latitude);
    setState(() {
      locationcontroller.text = '${loc.latitude},${loc.longitude}';
    });
  }

  String? selectedDistrict;
  String? type;
  String? auname;

  List districts = [
    'Kasargod',
    'Kannur',
    'kozhikode',
    'Wayanad',
    'Malapuram',
    'Thrissur',
    'Palakkad',
    'Ernakulam',
    'Idukki',
    'Kottayam',
    'Alappuzha',
    'Pathanamthitta',
    'Kollam',
    'Thiruvananthapuram'
  ];
  List authority = ['corporation', 'Muncipality', 'Panchayath'];

  getData() async {
    final Response res =
        await get(Uri.parse(ConstantData.baseUrl + 'subadmin_detail'));
    final List data = jsonDecode(res.body);
    return data.map((e) => Authority.fromJson(e)).toList();
  }

  register(BuildContext context) async {
    final response = await post(
        Uri.parse(ConstantData.baseUrl + 'wrkshop_registration'),
        body: {
          'username': usernamecontroller.text,
          'password1': passwordcontroller.text,
          'password2': passwordcontroller.text,
          'address': addresscontroller.text,
          'phone_number': phonecontroller.text,
          'licence_number': licencecontroller.text,
          'workshop_name': workshopnamecontroller.text,
          'owner_name': ownernamecontroller.text,
          'location': locationcontroller.text,
          'district': selectedDistrict,
          'authority_type': type,
          'authority_name': auname,
          'type': 'workshop'
        });
    final data = jsonDecode(response.body);
    print(response.body);
    if (data['result'] != false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
      );
    }
  }

  test() {}

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .001),
                child: TextFormField(
                  controller: workshopnamecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('workshop name')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .001),
                child: TextFormField(
                  controller: ownernamecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('owner name')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .001),
                child: TextFormField(
                  controller: addresscontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 6,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('address')),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: 80, vertical: deviceHeight * .001),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         label: Text('pincode')),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 90, vertical: deviceHeight * .001),
                child: DropdownButton(
                    hint: Text('districts'),
                    value: selectedDistrict,
                    items: districts
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        selectedDistrict = v as String;
                      });
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 100, vertical: deviceHeight * .002),
                child: DropdownButton(
                    hint: Text('Authority type'),
                    value: type,
                    items: authority
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        type = v as String;
                      });
                    }),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: 80, vertical: deviceHeight * .001),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         label: Text('Authority name')),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 90, vertical: deviceHeight * .001),
                child: FutureBuilder(
                    future: getData(),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return DropdownButton(
                            hint: Text('Authority name'),
                            value: auname,
                            items: (snap.data as List<Authority>)
                                // []
                                .where((element) =>
                                    element.district == selectedDistrict &&
                                    element.AuthorityType == type)
                                .map((e) => DropdownMenuItem(
                                      child: Text(e.name),
                                      value: e.name,
                                    ))
                                .toList(),
                            onChanged: (v) {
                              setState(() {
                                auname = v as String;
                              });
                            });
                      }
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: deviceWidth - 100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 80, vertical: deviceHeight * .001),
                      child: TextFormField(
                        controller: locationcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'textfield is empty';
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('location')),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        print('object');
                        gps();
                      },
                      icon: Icon(Icons.my_location))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .001),
                child: TextFormField(
                  controller: phonecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    } else if (value.length != 10) {
                      return 'enter a avlid phone number';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('phone number')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .001),
                child: TextFormField(
                  controller: licencecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('licence number')),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: 80, vertical: deviceHeight * .001),
              //   child: TextField(
              //     keyboardType: TextInputType.phone,
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         label: Text('sevices')),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: 80, vertical: deviceHeight * .001),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         label: Text('working time')),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .01),
                child: TextFormField(
                  controller: usernamecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    } else if (value.length < 3) {
                      return 'username is too short';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('user name')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .001),
                child: TextFormField(
                  controller: passwordcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    }
                  },
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('password')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .001),
                child: TextFormField(
                  controller: confpasswordcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    } else if (value != passwordcontroller.text) {
                      return 'password does not match';
                    }
                  },
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('confirm password')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 150, vertical: deviceHeight * .001),
                child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        register(context);
                      }
                    },
                    child: Text('Register')),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
