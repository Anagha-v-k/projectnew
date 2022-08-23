import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import 'package:vehicleassistant/Models/workshop_feedback.dart';
import 'package:vehicleassistant/constants/constant_data.dart';

class ViewFeedback extends StatelessWidget {
  const ViewFeedback({Key? key}) : super(key: key);

  Future<List<WorkshopFeedback>> getFeedback() async {
    final spref = await SharedPreferences.getInstance();
    print(spref.getString('userid'));
    Response res = await get(Uri.parse(ConstantData.baseUrl + 'add_feedback'));
    print(res.body);
    List data = jsonDecode(res.body);
    return data
        .map((e) => WorkshopFeedback.fromJson(e))
        .toList()
        .where((element) =>
            element.workshop.toString() == spref.getString('userid'))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getFeedback(),
          builder: (context, AsyncSnapshot<List<WorkshopFeedback>> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snap.hasData) {
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SimpleStarRating(
                                starCount: 5,
                                isReadOnly: true,
                                rating: double.parse(snap.data![index].rating),
                              ),
                              Text(snap.data![index].comment)
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('no data'),
              );
            }
          }),
    );
  }
}
