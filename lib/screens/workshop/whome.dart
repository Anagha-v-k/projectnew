import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/screens/workshop/change_status.dart';
import 'package:vehicleassistant/screens/workshop/srevices.dart';
import 'package:vehicleassistant/screens/workshop/work_order.dart';

import '../../user/fuel.dart';
import '../login_page.dart';
import '../petrolpumb/addserviceman.dart';

class Whome extends StatelessWidget {
  const Whome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Assistant'),
        centerTitle: true,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              "https://assets3.lottiefiles.com/private_files/lf30_tr47e8ve.json",
              "https://assets7.lottiefiles.com/packages/lf20_6wbxjhf1.json",
              "https://assets8.lottiefiles.com/packages/lf20_znsmxbjo.json"
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      // decoration: BoxDecoration(color: Colors.amber),
                      child: Lottie.network(
                        i,
                      ));
                },
              );
            }).toList(),
          ),
          Container(
            width: 200,
            height: 70,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewWorkreqFromUser();
                }));
              },
              child: Text('view orders'),
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return Servman();
          //       }));
          //     },
          //     child: Text('add services'),
          //   ),
          // ),
          Container(
            // width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Servman();
                }));
              },
              child: Text('view feedback'),
            ),
          ),
          Container(
            // width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChangeStatus();
                }));
              },
              child: Text('add status'),
            ),
          ),
        ],
      ),
    );
  }
}
