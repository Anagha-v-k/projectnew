import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/constants/constant_data.dart';
import 'package:vehicleassistant/screens/petrol_register.dart';
import 'package:vehicleassistant/screens/petrolpumb/petrolhome.dart';
import 'package:vehicleassistant/screens/user_register.dart';
import 'package:vehicleassistant/screens/userhome.dart';
import 'package:vehicleassistant/screens/workreg.dart';
import 'package:vehicleassistant/screens/workshop/whome.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  login(BuildContext context) async {
    print('working');
    final response = await post(Uri.parse(ConstantData.baseUrl + 'login_views'),
        body: {
          'uname': usernamecontroller.text.trim(),
          'pass': passwordcontroller.text.trim(),
        });
    final data = jsonDecode(response.body);
    print('response' + response.body);
    if (data['result'] != false) {
      final spref = await SharedPreferences.getInstance();
      spref.setString('userid', data['result']['id'].toString());
      spref.setString('type', data['result']['type']);
      if (data['result']['type'] == 'petrolpumb') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return Phome();
          }),
        );
      } else if (data['result']['type'] == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return Userhome();
          }),
        );
      } else if (data['result']['type'] == 'workshop') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return Whome();
          }),
        );
      } else {
        Fluttertoast.showToast(msg: 'login failed');
      }

      print(response.body);
    } else {
      Fluttertoast.showToast(msg: 'login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network(
                  'https://assets3.lottiefiles.com/packages/lf20_lpmjb80e.json',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: deviceHeight * .01),
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
                        border: OutlineInputBorder(), label: Text('User name')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: deviceHeight * .01),
                  child: TextFormField(
                    controller: passwordcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password is empty';
                      } else if (value.length < 3) {
                        return 'password is too short';
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text('Password')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ElevatedButton(
                      onPressed: () {
                        // print('tapped');
                        if (formkey.currentState!.validate()) {
                          // print('ok');
                          login(context);
                        }
                      },
                      child: Text('Login')),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text('sign up as'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UserReg();
                          }));
                        },
                        child: Text('user')),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Preg();
                          }));
                        },
                        child: Text('petrol pumb')),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return WrkReg();
                          }));
                        },
                        child: Text('workshop')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
