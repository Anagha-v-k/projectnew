import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vehicleassistant/screens/petrolpumb/petrolhome.dart';

class Servman extends StatelessWidget {
  const Servman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('name')),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('id no')),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 50),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('mobile number')),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Phome();
                    },
                  ),
                );
              },
              child: Text('Add')),
        ]),
      ),
    );
  }
}
