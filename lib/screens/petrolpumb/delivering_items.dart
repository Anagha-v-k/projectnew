import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vehicleassistant/Models/petrol_request.dart';
import 'package:vehicleassistant/constants/constant_data.dart';

class DeliveringItems extends StatefulWidget {
  DeliveringItems({Key? key}) : super(key: key);

  @override
  State<DeliveringItems> createState() => _ViewreqState();
}

class _ViewreqState extends State<DeliveringItems> {
  SharedPreferences? spref;

  Future<List<PetrolRequest>> getRequests() async {
    // Fluttertoast.showToast(msg: 'err.toString()');
    print('object');
    spref = await SharedPreferences.getInstance();
    final res =
        await http.get(Uri.parse(ConstantData.baseUrl + 'frequest_view'));
    final List data = jsonDecode(res.body);
    print(data);
    print('f_request view ${data.map((e) => PetrolRequest.fromJson(e))}');
    return data.map((e) => PetrolRequest.fromJson(e)).toList();
  }

  accept(String id) async {
    http.Response res = await http.patch(
        Uri.parse(ConstantData.baseUrl + 'Status/$id'),
        body: {'status': '1'});
    print(res.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print('object');
    // Fluttertoast.showToast(msg: 'asd');
    return Scaffold(
      body: FutureBuilder(
          future: getRequests(),
          builder: (context, AsyncSnapshot<dynamic> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snap.hasData) {
              List<PetrolRequest> filteredList = snap.data!.where((element) {
                print(
                    'id from data: ${element.Petrolpumb} id of user: ${spref!.getString('userid')}');
                return element.Petrolpumb.toString() ==
                        spref!.getString('userid') &&
                    element.date ==
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
              }).toList();
              filteredList.sort((a, b) => a.date.compareTo(b.date));
              return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    filteredList.sort((a, b) {
                      return a.status.compareTo(b.status);
                    });
                    return Card(
                      child: ListTile(
                        onTap: () {
                          launchUrl(Uri.parse(
                              'https://www.google.com/maps/search/?api=1&query=${filteredList[index].location.split(',').first},${filteredList[index].location.split(',').last}'));
                        },
                        // contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 40,
                          child: Text(
                              '₹${double.parse(filteredList[index].amount).round()}'),
                        ),
                        title: Text(filteredList[index].name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(filteredList[index].product),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.call),
                                Text(filteredList[index].phoneNumber),
                              ],
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: filteredList[index].status == '1'
                                    ? Colors.amber
                                    : Colors.green),
                            onPressed: () {
                              accept(filteredList[index].id.toString());
                            },
                            child: Text(filteredList[index].status == '1'
                                ? 'Accepted'
                                : 'Accept')),
                      ),
                    );
                  });
            } else {
              return Center(child: Text('no data'));
            }
          }),
    );
  }
}
