import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vehicleassistant/Models/petrol_request.dart';
import 'package:vehicleassistant/Models/workshop_request.dart';
import 'package:vehicleassistant/constants/constant_data.dart';

class ViewWorkreqFromUser extends StatefulWidget {
  ViewWorkreqFromUser({Key? key}) : super(key: key);

  @override
  State<ViewWorkreqFromUser> createState() => _ViewWorkreqFromUserState();
}

class _ViewWorkreqFromUserState extends State<ViewWorkreqFromUser> {
  SharedPreferences? spref;

  Future<List<WorkshopRequest>> getRequests() async {
    spref = await SharedPreferences.getInstance();
    final res = await get(Uri.parse(ConstantData.baseUrl + 'Wrequest_view'));
    final List data = jsonDecode(res.body);
    print('f_request view $data');
    return data.map((e) => WorkshopRequest.fromJson(e)).toList();
  }

  accept(String id) async {
    Response res = await patch(Uri.parse(ConstantData.baseUrl + 'Wstatus/$id'),
        body: {'status': '1'});
    print(res.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getRequests(),
          builder: (context, AsyncSnapshot<List<WorkshopRequest>> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              List<WorkshopRequest> filteredList = snap.data!
                  .where((element) =>
                      element.date ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now()))
                  .toList();
              // List<WorkshopRequest> filteredList = snap.data!.where((element) {
              //   print(
              //       'id from data: ${element.workshop} id of user: ${spref!.getString('userid')}');
              //   return element.workshop == spref!.getString('userid');
              //   // &&
              //   //     element.date ==
              //   //         DateFormat('yyyy-MM-dd').format(DateTime.now()
              //   //         );
              // }).toList();
              filteredList.sort((a, b) => a.status.compareTo(b.status));
              return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          launchUrl(Uri.parse(
                              'https://www.google.com/maps/search/?api=1&query=${filteredList[index].location.split(',').first},${filteredList[index].location.split(',').last}'));
                        },
                        // leading: CircleAvatar(
                        //   radius: 40,
                        //   child: Text('₹${1
                        //       // double.parse(filteredList[index].vehicleModel).round()
                        //       }'),
                        // ),

                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'complaint : ${filteredList[index].problem}'),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'phone number : ${filteredList[index].phoneNumber}'),
                              Text('name : ${filteredList[index].name}'),
                              Text(
                                  'vehicle model : ${filteredList[index].vehicleModel}'),
                            ],
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    primary: filteredList[index].status == '0'
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withAlpha(50)
                                        : Colors.amber),
                                onPressed: () {
                                  accept(filteredList[index].id.toString());
                                },
                                child: Text(filteredList[index].status == '0'
                                    ? 'Accept'
                                    : 'Accepted')),
                            SizedBox(
                              width: 3,
                            ),
                            // ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //         primary: Color.fromARGB(255, 255, 151, 53)),
                            //     onPressed: () {},
                            //     child: Text('Reject')),
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
