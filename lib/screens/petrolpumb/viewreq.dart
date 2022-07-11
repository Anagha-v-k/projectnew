import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:vehicleassistant/Models/petrol_request.dart';
import 'package:vehicleassistant/constants/constant_data.dart';

class Viewreq extends StatelessWidget {
  const Viewreq({Key? key}) : super(key: key);

  Future<List<PetrolRequest>> getRequests() async {
    final res = await get(Uri.parse(ConstantData.baseUrl + 'frequest_view'));
    final List data = jsonDecode(res.body);
    print('f_request view $data');
    return data.map((e) => PetrolRequest.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getRequests(),
          builder: (context, AsyncSnapshot<List<PetrolRequest>> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snap.data![index].product),
                    );
                  });
            }
          }),
    );
  }
}
