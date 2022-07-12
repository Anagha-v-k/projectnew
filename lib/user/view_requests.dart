import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vehicleassistant/Models/petrol_request.dart';
import 'package:vehicleassistant/constants/constant_data.dart';

class ViewreqFromUser extends StatelessWidget {
  ViewreqFromUser({Key? key}) : super(key: key);
  SharedPreferences? spref;
  Future<List<PetrolRequest>> getRequests() async {
    spref = await SharedPreferences.getInstance();
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
              List<PetrolRequest> filteredList = snap.data!.where((element) {
                print(
                    'id from data: ${element.customer} id of user: ${spref!.getString('userid')}');
                return element.customer == spref!.getString('userid') &&
                    element.date ==
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
              }).toList();
              filteredList.sort((a, b) => a.date.compareTo(b.date));
              return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          launchUrl(Uri.parse(
                              'https://www.google.com/maps/search/?api=1&query=${filteredList[index].location.split(',').first},${filteredList[index].location.split(',').last}'));
                        },
                        leading: CircleAvatar(
                          radius: 40,
                          child: Text(
                              '₹${double.parse(filteredList[index].amount).round()}'),
                        ),
                        title: Text(filteredList[index].product),
                        subtitle: Text(filteredList[index].phoneNumber),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                                onPressed: () {},
                                child: Text('Accept')),
                            SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                onPressed: () {},
                                child: Text('Reject')),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
