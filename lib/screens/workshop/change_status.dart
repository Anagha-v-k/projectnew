import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/constants/constant_data.dart';

class ChangeStatus extends StatefulWidget {
  const ChangeStatus({Key? key}) : super(key: key);

  @override
  State<ChangeStatus> createState() => _ChangeStatusState();
}

var status = true;

changeStatus() async {
  SharedPreferences spref = await SharedPreferences.getInstance();
  final res = await patch(
      Uri.parse(ConstantData.baseUrl +
          'wavailableStatus/${spref.getString('userid')}'),
      body: {'status': status ? 'open' : 'closed'});
  print(res.body);
}

class _ChangeStatusState extends State<ChangeStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('data'),),
      body: Center(
        child: Transform.scale(
          scale: 4,
          child: Switch(
              activeThumbImage: NetworkImage(
                  'https://previews.123rf.com/images/ionutparvu/ionutparvu1612/ionutparvu161201726/67602998-active-stamp-sign-text-word-logo-blue-.jpg'),
              value: status,
              onChanged: (v) {
                setState(() {
                  status = !status;
                });
                changeStatus();
                print(v);
              }),
        ),
      ),
    );
  }
}
