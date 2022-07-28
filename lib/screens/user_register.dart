import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:vehicleassistant/screens/userhome.dart';

import '../constants/constant_data.dart';
import 'login_page.dart';

class UserReg extends StatelessWidget {
  UserReg({Key? key}) : super(key: key);
  final usernamecontroller = TextEditingController();
  final licencecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confpasswordcontroller = TextEditingController();

  final formkey = GlobalKey<FormState>();
  register(BuildContext context) async {
    print(usernamecontroller.text);
    final response = await post(
        Uri.parse(ConstantData.baseUrl + 'user_registration'),
        body: {
          'username': usernamecontroller.text,
          'password1': passwordcontroller.text,
          'password2': passwordcontroller.text,
          'address': addresscontroller.text,
          'phone_number': phonecontroller.text,
          'licence_number': licencecontroller.text,
          'type': 'user'
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

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      horizontal: 80, vertical: deviceHeight * .01),
                  child: TextFormField(
                    controller: licencecontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'textfield is empty';
                      } else if (!value.contains('/') || value.length != 12) {
                        return 'license number not valid';
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('license number')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 80, vertical: deviceHeight * .01),
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 80, vertical: deviceHeight * .01),
                  child: TextFormField(
                    controller: phonecontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'textfield is empty';
                      } else if (value.length != 10) {
                        return 'enter valid phone number';
                      }
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('phone number')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 80, vertical: deviceHeight * .01),
                  child: TextFormField(
                    controller: passwordcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'textfield is empty';
                      } else if (value.length < 3) {
                        return 'password is too short';
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text('password')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 80, vertical: deviceHeight * .01),
                  child: TextFormField(
                    controller: confpasswordcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'textfield is empty';
                      } else if (value != passwordcontroller.text) {
                        return 'password does not match';
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('confirm password')),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      print('tapped');
                      if (formkey.currentState!.validate()) {
                        register(context);
                      }
                    },
                    child: Text('Register')),

                // TextButton(
                //     onPressed: () {
                //       Navigator.push(context, MaterialPageRoute(builder: (context) {
                //         return LoginPage();
                //       }));
                //     },
                //     child: Text('Sign In'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
