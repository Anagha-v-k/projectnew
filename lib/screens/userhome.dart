import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/screens/login_page.dart';
import 'package:vehicleassistant/user/profile.dart';
import 'package:vehicleassistant/user/repair_requests.dart';
import 'package:vehicleassistant/user/view_requests.dart';
import 'package:vehicleassistant/user/view_spare.dart';

import '../user/chat.dart';
import '../user/fuel.dart';
import '../user/user_drawer.dart';
import '../user/work.dart';

class Userhome extends StatelessWidget {
  const Userhome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: UserDrawer(),
      backgroundColor: Color.fromRGBO(234, 252, 252, 1),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Vehicle Assistant'),
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
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Lottie.network(
                "https://assets7.lottiefiles.com/packages/lf20_iu2eauds.json",
              ),
            ),
            Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: deviceHeight * .1),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Fuel();
                  }));
                },
                leading: Icon(Icons.local_gas_station),
                title: Text('Nearest fuel stations'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Work();
                  }));
                },
                leading: Icon(Icons.build),
                title: Text('Nearest Workshops'),
              ),
              // ListTile(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return Chat();
              //     }));
              //   },
              //   leading: Icon(Icons.forum),
              //   title: Text('Chat with mechanics'),
              // ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ViewSpare();
                  }));
                },
                leading: Icon(Icons.shopping_cart),
                title: Text('Order Spare Parts'),
              ),
              // ListTile(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return Prof();
              //     }));
              //   },
              //   leading: Icon(Icons.person),
              //   title: Text('View profile'),
              // )
            ]),
          ],
        ),
      ),
    );
  }
}
