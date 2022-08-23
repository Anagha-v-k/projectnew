import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/user/order_status.dart';
import 'package:vehicleassistant/user/repair_requests.dart';
import 'package:vehicleassistant/user/view_requests.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({
    Key? key,
  }) : super(key: key);

  Future<String?> getUsername() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    return spref.getString('name');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(30),
            child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  'https://www.globalassure.com/images/services/rsa.png'),
            ),
          ),
          FutureBuilder(
              future: getUsername(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return Text(
                    snap.data.toString(),
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(.35),
                              blurRadius: 5,
                              offset: Offset(-2, 2))
                        ]),
                  );
                } else {
                  return Text('...');
                }
              }),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewreqFromUser()));
              },
              leading: Icon(Icons.history),
              title: Text('petrol requests'),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RepairRequests()));
              },
              leading: Icon(Icons.history),
              title: Text('repair requests'),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderStatus()));
              },
              leading: Icon(Icons.history),
              title: Text('track your order'),
            ),
          ),
        ],
      ),
    ));
  }
}
