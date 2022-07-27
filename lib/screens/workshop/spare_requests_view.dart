import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vehicleassistant/Models/petrol_request.dart';
import 'package:vehicleassistant/constants/constant_data.dart';

class ViewSpareRequests extends StatefulWidget {
  ViewSpareRequests({Key? key}) : super(key: key);

  @override
  State<ViewSpareRequests> createState() => _ViewreqState();
}

class _ViewreqState extends State<ViewSpareRequests> {
  SharedPreferences? spref;

// -------------------------------------------
// JUST COPY AND PASTED THE SCREEN
// DO THE REMAINING
// -------------------------------------------

  Future<List<PetrolRequest>> getRequests() async {
    spref = await SharedPreferences.getInstance();
    final res =
        await http.get(Uri.parse(ConstantData.baseUrl + 'frequest_view'));
    final List data = jsonDecode(res.body);
    print('f_request view $data');
    return data.map((e) => PetrolRequest.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel requests'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getRequests(),
          builder: (context, AsyncSnapshot<List<PetrolRequest>> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (!snap.hasData) {
                return Center(child: Text('no data'));
              }
              List<PetrolRequest> filteredList = snap.data!.where((element) {
                // print(
                //     'id from data: ${element.Petrolpump} id of user: ${spref!.getString('userid')}');
                return element.customer.toString() ==
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
                          // launchUrl(Uri.parse(
                          //     'https://www.google.com/maps/search/?api=1&query=${filteredList[index].location.split(',').first},${filteredList[index].location.split(',').last}'));
                        },
                        contentPadding: EdgeInsets.all(10),
                        leading: CircleAvatar(
                          radius: 40,
                          child: Text(
                              '₹${double.parse(filteredList[index].amount).round()}'),
                        ),
                        title: Text(filteredList[index].product.toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(filteredList[index].Petrolpumb1),
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
                            onPressed: () {},
                            child: Text(filteredList[index].status == '1'
                                ? 'Accepted'
                                : 'Pending')),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
