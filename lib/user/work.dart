import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';
import 'package:vehicleassistant/user/petrolorder.dart';
import 'package:vehicleassistant/user/rating.dart';
import 'package:vehicleassistant/user/workreq.dart';

class Work extends StatelessWidget {
  Work({Key? key}) : super(key: key);
  final userLocation = '11.304020540521964,75.75696906515643';
  var wrk = [
    {'name': 'wrk1', 'coordinates': '11.302800136009576,75.76851329200237'},
    {'name': 'wrk2', 'coordinates': '11.3028001360095456,75.76851329300237'},
    {'name': 'wrk3', 'coordinates': '11.3028001360095476,75.76851329200237'},
    {'name': 'wrk4', 'coordinates': '11.3028001360095466,45.76851329200237'}
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
        body: ListView.builder(
            itemCount: wrk.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Workreq()));
                },
                child: Card(
                  child: ListTile(
                    title: Text(wrk[index]['name']!),
                    subtitle: Text(calculateDistance(
                            double.parse(userLocation.split(',').first),
                            double.parse(userLocation.split(',')[1]),
                            double.parse(
                                wrk[index]['coordinates']!.split(',').first),
                            double.parse(
                                wrk[index]['coordinates']!.split(',')[1]))
                        .toString()),
                  ),
                ),
              );
            }));
  }
}
