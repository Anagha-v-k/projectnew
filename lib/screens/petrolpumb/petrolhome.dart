import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/screens/petrolpumb/viewreq.dart';
import 'package:vehicleassistant/user/fuel.dart';
import 'package:vehicleassistant/user/rating.dart';

import '../login_page.dart';
import 'addserviceman.dart';

class Phome extends StatelessWidget {
  const Phome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final spref = await SharedPreferences.getInstance();
                spref.clear();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 400,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  "https://assets6.lottiefiles.com/packages/lf20_0ec3p5o6.json",
                  "https://assets3.lottiefiles.com/packages/lf20_3t09De.json",
                  "https://assets3.lottiefiles.com/packages/lf20_caijenqq.json"
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          // decoration: BoxDecoration(color: Colors.amber),
                          child: Lottie.network(i, width: 400, height: 250));
                    },
                  );
                }).toList(),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: InkWell(
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Viewreq();
                            }),
                          )),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text("View Request"),
                        ),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: InkWell(
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Servman();
                            }),
                          )),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text("Add ServiceMan"),
                        ),
                      ),
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
