import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constant_data.dart';
import '../screens/userhome.dart';

class Porder extends StatefulWidget {
  const Porder(
      {required String this.petrolId, required double this.distance, Key? key})
      : super(key: key);
  final String petrolId;
  final double distance;
  @override
  State<Porder> createState() => _PorderState();
}

class _PorderState extends State<Porder> {
  List items = ['petrol', 'diesel', 'adblue'];
  // final usernamecontroller = TextEditingController();
  final amountController = TextEditingController();
  final PhoneController = TextEditingController();
  final nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String? selected;
  Future<dynamic> order(BuildContext context, double amount) async {
    final spref = await SharedPreferences.getInstance();
    // print(usernamecontroller.text);
    LocationData locData = await Location.instance.getLocation();

    try {
      final response =
          await post(Uri.parse(ConstantData.baseUrl + 'addfrequest'), body: {
        'customer': spref.getString('userid'),
        'Petrolpumb': widget.petrolId,
        'product': selected,
        'name': nameController.text,
        'location': '${locData.latitude},${locData.longitude}',
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'time': DateFormat('hh:mm:ss').format(DateTime.now()),
        'status': '0',
        'amount': amount.toString(),
        'phone_number': PhoneController.text,
      });
      final data = jsonDecode(response.body);
      print('resss $data');
      if (data != null) {
        Fluttertoast.showToast(msg: 'successfully ordered!!!');
        if (!mounted) return;
        Navigator.pop(context);
        Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return Userhome();
        //     },
        //   ),
        // );

      }
    } on Exception catch (err) {
      Fluttertoast.showToast(msg: 'Something went wrong');
      print('exception: $err');
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deliveryCharge = 10 + (widget.distance * 5);
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: formkey,
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 90, vertical: 10),
            child: DropdownButton(
                hint: Text('product'),
                value: selected,
                items: items
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    selected = v as String;
                  });
                }),
          ),
          Text('Delivery charge* ₹$deliveryCharge will be applied'),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 80, vertical: deviceHeight * .01),
            child: TextFormField(
              controller: amountController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'textfield is empty';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Amount')),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 80, vertical: deviceHeight * .01),
            child: TextFormField(
              controller: PhoneController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'textfield is empty';
                } else if (value.length != 10) {
                  return 'enter valid phone number';
                }
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('phone number')),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 80, vertical: deviceHeight * .01),
            child: TextFormField(
              controller: nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'textfield is empty';
                }
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('name')),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Grand Total'),
                          content: Text(
                              '${amountController.text}+$deliveryCharge = ${double.parse(amountController.text) + deliveryCharge}'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  order(
                                          context,
                                          double.parse(amountController.text) +
                                              deliveryCharge)
                                      .then((_) => Navigator.pop(context));
                                },
                                child: Text('Proceed'))
                          ],
                        );
                      });
                  // order(context);
                }
              },
              child: Text('order')),
          Expanded(child: Container()),
          Text('*minimum delivery charge ₹10, per kilometer charge ₹5')
        ]),
      ),
    ));
  }
}
