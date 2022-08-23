import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import 'package:vehicleassistant/Models/workshop_model.dart';
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

  Future<double> calculateRating(String id) async {
    // print('id $id');
    double rating = 0.0;
    http.Response res =
        await http.get(Uri.parse(ConstantData.baseUrl + 'add_feedback'));
    // print('rawfeeds ${jsonDecode(res.body)}');
    List rawFeedbacks = (jsonDecode(res.body) as List)
        .where((element) => element['workshop'].toString() == id)
        .toList();
    // print('feeds ${rawFeedbacks}');
    rawFeedbacks.forEach((element) {
      rating = rating + double.parse(element['rating']);
    });
    print('rating $rating');
    print(rating / (jsonDecode(res.body) as List).length);
    return rating / (jsonDecode(res.body) as List).length;
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
              builder: (context, AsyncSnapshot<List<Workshop>> snapshot) {
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
                  var wrk = snapshot.data!;
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
                                          workshopId: wrk[index].id.toString(),
                                        )));
                          },
                          child: Card(
                            child: ListTile(
                              // tileColor: snapshot.data![index].status == 'open'
                              //     ? Colors.purple[100]
                              //     : Colors.grey,
                              trailing: FutureBuilder(
                                  future:
                                      calculateRating(wrk[index].id.toString()),
                                  builder:
                                      (context, AsyncSnapshot<double> snap) {
                                    if (!snap.hasData) {
                                      return CircularProgressIndicator();
                                    } else {
                                      return SimpleStarRating(
                                          rating: snap.data!);
                                    }
                                  }),
                              title: Text(wrk[index].workshopName),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${calculateDistance(userLocation!.latitude, userLocation!.longitude, double.parse(wrk[index].location.split(',').first), double.parse(wrk[index].location.split(',')[1])).toStringAsFixed(2)} Km'),
                                  Text(
                                    snapshot.data![index].status,
                                    style: TextStyle(
                                        color: snapshot.data![index].status ==
                                                'open'
                                            ? Colors.black
                                            : Colors.red),
                                  ),
                                ],
                              ),
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

  Future<List<Workshop>> getData() async {
    userLocation = await Location.instance.getLocation();

    final result =
        await http.get(Uri.parse('${ConstantData.baseUrl}workshopview'));
    print('......................${result.body}');
    final List data = jsonDecode(result.body);
    return data.map((e) => Workshop.fromJson(e)).toList();
  }
}
