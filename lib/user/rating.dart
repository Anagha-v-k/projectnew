import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

import '../Models/workshop_feedback.dart';
import '../constants/constant_data.dart';
import '../screens/userhome.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key, required this.workshopId}) : super(key: key);
  final String workshopId;
  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double rating = 1;

  final ratingcontroller = TextEditingController();
  final feedbackcontroller = TextEditingController();

  Future<List<WorkshopFeedback>> getFeedback() async {
    Response res = await get(Uri.parse(ConstantData.baseUrl + 'add_feedback'));
    print(res.body);
    List data = jsonDecode(res.body);
    return data
        .map((e) => WorkshopFeedback.fromJson(e))
        .toList()
        .where((element) => element.workshop.toString() == widget.workshopId)
        .toList();
  }

  postfeed(BuildContext context) async {
    final spref = await SharedPreferences.getInstance();
    final param = {
      'customer': spref.getString('userid'),
      'workshop': widget.workshopId,
      'rating': rating.toString(),
      'comment': feedbackcontroller.text,
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    };
    print(param);
    final response = await post(
        Uri.parse(ConstantData.baseUrl + 'add_feedback'),
        body: param);
    final data = jsonDecode(response.body);
    print(data);
    if (data['result'] != false) {
      Fluttertoast.showToast(msg: 'successfully posted feedback!!!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Userhome();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 400,
                  child: FutureBuilder(
                      future: getFeedback(),
                      builder: (context,
                          AsyncSnapshot<List<WorkshopFeedback>> snap) {
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SimpleStarRating(
                                            starCount: 5,
                                            isReadOnly: true,
                                            rating: double.parse(
                                                snap.data![index].rating),
                                          ),
                                          Text(snap.data![index].comment),
                                          Text(snap.data![index].date)
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
                ),
                SimpleStarRating(
                  allowHalfRating: true,
                  starCount: 5,
                  rating: rating,
                  size: 32,
                  isReadOnly: false,
                  onRated: (rate) {
                    setState(() {
                      rating = rate!;
                    });
                  },
                  spacing: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    minLines: 2,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    controller: feedbackcontroller,
                    decoration: const InputDecoration(
                      hintText: 'description',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        postfeed(context);
                      }
                    },
                    child: Text("Post feedback"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
