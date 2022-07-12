import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';
import 'package:vehicleassistant/user/petrolorder.dart';
import 'package:vehicleassistant/user/rating.dart';
import 'package:vehicleassistant/user/workreq.dart';
import 'package:http/http.dart' as http;

import '../constants/constant_data.dart';

class Work extends StatelessWidget {
  Work({Key? key}) : super(key: key);
  LocationData? userLocation;
  var wrk = [
    // {'workshop_name': 'wrk1', 'location': '11.302800136009576,75.76851329200237'},
  ];
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Lottie.network(
                "https://assets6.lottiefiles.com/packages/lf20_6wbxjhf1.json",
                height: 250),
          ),
          FutureBuilder(
              future: getData(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                wrk.sort((a, b) => calculateDistance(
                        userLocation!.latitude,
                        userLocation!.longitude,
                        double.parse(a['location']!.split(',').first),
                        double.parse(a['location']!.split(',')[1]))
                    .round()
                    .compareTo(calculateDistance(
                        userLocation!.latitude,
                        userLocation!.longitude,
                        double.parse(b['location']!.split(',').first),
                        double.parse(b['location']!.split(',')[1]))));
                if (snapshot.hasData) {
                  wrk = jsonDecode(snapshot.data!);
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: wrk.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Workreq(
                                          workshopId:
                                              wrk[index]['id'].toString(),
                                        )));
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(wrk[index]['workshop_name']!),
                              subtitle: Text(
                                  '${calculateDistance(userLocation!.latitude, userLocation!.longitude, double.parse(wrk[index]['location']!.split(',').first), double.parse(wrk[index]['location']!.split(',')[1])).toStringAsFixed(2)} Km'),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("something went wrong..."),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    ));
  }

  Future<String> getData() async {
    userLocation = await Location.instance.getLocation();

    final result =
        await http.get(Uri.parse('${ConstantData.baseUrl}workshopview'));
    print('......................${result.body}');
    return result.body;
  }
}
