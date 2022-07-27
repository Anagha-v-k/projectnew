import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:vehicleassistant/Models/authority_model.dart';
import 'package:vehicleassistant/constants/constant_data.dart';
import 'package:vehicleassistant/screens/login_page.dart';

// import 'package:location/location.dart';
import 'package:vehicleassistant/screens/petrolpumb/petrolhome.dart';

class Preg extends StatefulWidget {
  Preg({Key? key}) : super(key: key);

  @override
  State<Preg> createState() => _PregState();
}

class _PregState extends State<Preg> {
  final locationcontroller = TextEditingController();

  final usernamecontroller = TextEditingController();
  final licencecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confpasswordcontroller = TextEditingController();
  final companynamecontroller = TextEditingController();
  final ownernamecontroller = TextEditingController();
  final districtcontroller = TextEditingController();
  // final authtypecontroller = TextEditingController();
  // final authnamecontroller = TextEditingController();
  final startcontroller = TextEditingController();
  final endcontroller = TextEditingController();

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
    print(data);
    return data.map((e) => Authority.fromJson(e)).toList();
  }

  register(BuildContext context) async {
    final response = await post(
        Uri.parse(ConstantData.baseUrl + 'petrol_registration'),
        body: {
          'username': usernamecontroller.text,
          'password1': passwordcontroller.text,
          'password2': passwordcontroller.text,
          'address': addresscontroller.text,
          'phone_number': phonecontroller.text,
          'licence_number': licencecontroller.text,
          'company_name': companynamecontroller.text,
          'owner_name': ownernamecontroller.text,
          'district': selectedDistrict,
          'location': locationcontroller.text,
          // 'authority_type': type,
          // 'authority_name': auname,
          // 'start_time': startcontroller.text,
          // 'end_time': endcontroller.text,
          'type': 'petrolpumb'
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

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 184, 201),
      appBar: AppBar(),
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
                  controller: companynamecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('companyname')),
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
              //         border: OutlineInputBorder(), label: Text('pincode')),
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
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: 100, vertical: deviceHeight * .002),
              //   child: DropdownButton(
              //       hint: Text('Authority type'),
              //       value: type,
              //       items: authority
              //           .map((e) => DropdownMenuItem(
              //                 child: Text(e),
              //                 value: e,
              //               ))
              //           .toList(),
              //       onChanged: (v) {
              //         setState(() {
              //           type = v as String;
              //         });
              //       }),
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: 80, vertical: deviceHeight * .001),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         label: Text('Authority name')),
              //   ),
              // ),

              // Padding(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: 90, vertical: deviceHeight * .001),
              //     child: FutureBuilder(
              //         future: getData(),
              //         builder: (context, snap) {
              //           if (snap.connectionState == ConnectionState.waiting) {
              //             return CircularProgressIndicator();
              //           } else if (!snap.hasData) {
              //             return Text('No Authorities found');
              //           }
              //           {
              //             return DropdownButton(
              //                 hint: Text('Authority name'),
              //                 value: auname,
              //                 items: (snap.data as List<Authority>)
              //                     .where((element) =>
              //                         element.district == selectedDistrict &&
              //                         element.AuthorityType == type)
              //                     .map((e) => DropdownMenuItem(
              //                           child: Text(e.name),
              //                           value: e.name,
              //                         ))
              //                     .toList(),
              //                 onChanged: (v) {
              //                   setState(() {
              //                     auname = v as String;
              //                   });
              //                 });
              //           }
              //         })),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: deviceWidth - 100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 80, vertical: deviceHeight * .001),
                      child: TextField(
                        controller: locationcontroller,
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
                  controller: ownernamecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('ownername')),
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
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .001),
                child: TextFormField(
                  controller: phonecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    } else if (value.length != 10) {
                      return 'enter a valid phone number';
                    }
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('mobile number')),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: 80, vertical: deviceHeight * .001),
              //   child: TextFormField(
              //     controller: startcontroller,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'textfield is empty';
              //       }
              //     },
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         label: Text('work starting time')),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: 80, vertical: deviceHeight * .001),
              //   child: TextFormField(
              //     controller: endcontroller,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'textfield is empty';
              //       }
              //     },
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         label: Text('work ending time')),
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
                  // ki,eyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('password')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: deviceHeight * .001),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'textfield is empty';
                    } else if (value != passwordcontroller.text) {
                      return 'password does not match';
                    }
                  },
                  // obscureText: true,
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
