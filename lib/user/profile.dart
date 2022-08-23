import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vehicleassistant/constants/constant_data.dart';

class Prof extends StatelessWidget {
  const Prof({Key? key}) : super(key: key);

  getUserDetails() async {
    Response res = await get(Uri.parse(ConstantData.baseUrl + 'profile_view'));
    print(res.body);
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: getUserDetails(),
              builder: (context, snap) {
                return AlertDialog(
                  content: Column(children: [Text('username: ')]),
                );
              })),
    );
  }
}
