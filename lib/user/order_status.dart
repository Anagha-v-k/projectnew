import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/Models/spare_request_model.dart';
import 'package:vehicleassistant/constants/constant_data.dart';

class OrderStatus extends StatelessWidget {
  OrderStatus({Key? key}) : super(key: key);
  String? userid;
  Future<List<SpareRequest>> getRequests() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    userid = spref.getString('userid');
    Response res =
        await get(Uri.parse(ConstantData.baseUrl + 'view_sparerequest'));
    List data = jsonDecode(res.body);
    print(data);
    print('user id $userid');
    return data.map((e) => SpareRequest.fromJson(e)).toList();
  }

  var status = 'pending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getRequests(),
          builder: (context, AsyncSnapshot<List<SpareRequest>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              List filteredList = snapshot.data!
                  .where((element) => element.customer.toString() == userid)
                  .toList();
              return ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      trailing: Chip(
                          label: filteredList[index].status == 'pending'
                              ? Text('Pending')
                              : Text('Accepted'),
                          backgroundColor:
                              filteredList[index].status == 'pending'
                                  ? Colors.amber
                                  : Colors.green),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product: ${filteredList[index].product1}'),
                          Text('Address: ${filteredList[index].address}'),
                          Text('Pin: ${filteredList[index].pincode}'),
                        ],
                      ),
                      // leading: CircleAvatar(),
                      title: Text(filteredList[index].customerName),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
