import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChangeStatus extends StatelessWidget {
  const ChangeStatus({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('data'),),
      body: Center(child: Transform.scale(
        scale: 4,
        child: Switch(
          
          activeThumbImage: NetworkImage('https://previews.123rf.com/images/ionutparvu/ionutparvu1612/ionutparvu161201726/67602998-active-stamp-sign-text-word-logo-blue-.jpg'),
          value: true, onChanged: (v){
          print(v);
        }),
      ),),
    );
  }
}