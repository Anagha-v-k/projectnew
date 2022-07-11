import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:vehicleassistant/Models/petrol_pump.dart';
import 'package:vehicleassistant/constants/constant_data.dart';
import 'package:vehicleassistant/user/petrolorder.dart';

class Fuel extends StatelessWidget {
  Fuel({Key? key}) : super(key: key);

  LocationData? userLocation;

  List<Petrolpump> sorting = [];

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<List<PetrolPump>> getPetrolPumps() async {
    userLocation = await Location.instance.getLocation();
    final response = await get(Uri.parse(ConstantData.baseUrl + 'petrolview'));
    final List data = jsonDecode(response.body);
    print(data);
    print('....... ${data.map((e) => PetrolPump.fromJson(e))}');
    return data.map((e) => PetrolPump.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getPetrolPumps(),
            builder: (context, AsyncSnapshot<List<PetrolPump>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        double distance = calculateDistance(
                            userLocation!.latitude,
                            userLocation!.longitude,
                            double.parse(snapshot.data![index].location
                                .split(',')
                                .first),
                            double.parse(
                                snapshot.data![index].location.split(',')[1]));
                        sorting.add(Petrolpump(id: index, distance: distance));
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Porder(
                                          petrolId: snapshot.data![index].id
                                              .toString(),
                                          distance: double.parse(
                                              distance.toStringAsFixed(2)),
                                        )));
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(
                                  (snapshot.data as List<PetrolPump>)[index]
                                      .companyName),
                              subtitle:
                                  Text('${distance.toStringAsFixed(2)} Km'),
                            ),
                          ),
                        );
                      }),
                );
              }
            }));
  }

  // sort() {
  //   sorting.sort((a, b) => a.distance!.compareTo(b.distance!));
  // }
}

class Petrolpump {
  int? id;
  double? distance;
  Petrolpump({required this.id, required this.distance});
}
