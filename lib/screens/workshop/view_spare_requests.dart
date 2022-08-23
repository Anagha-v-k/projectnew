import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:vehicleassistant/Models/spare_request_model.dart';
import 'package:vehicleassistant/constants/constant_data.dart';

class ViewSpareRequest extends StatefulWidget {
  const ViewSpareRequest({Key? key}) : super(key: key);

  @override
  State<ViewSpareRequest> createState() => _ViewSpareRequestState();
}

class _ViewSpareRequestState extends State<ViewSpareRequest> {
  Future<List<SpareRequest>> getRequests() async {
    Response res =
        await get(Uri.parse(ConstantData.baseUrl + 'view_sparerequest'));
    List data = jsonDecode(res.body);
    print(data);
    return data.map((e) => SpareRequest.fromJson(e)).toList();
  }

  var status = 'pending';

  toggleStatus(String id) async {
    print(id);
    if (status == 'pending') {
      status = 'accepted';
      Response res = await patch(
          Uri.parse(ConstantData.baseUrl + 'Sparestatus/${id}'),
          body: {'status': 'accepeted'});
    } else {
      status = 'pending';

      Response res = await patch(
          Uri.parse(ConstantData.baseUrl + 'Sparestatus/${id}'),
          body: {'status': 'pending'});
    }

    setState(() {});
    // print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getRequests(),
          builder: (context, AsyncSnapshot<List<SpareRequest>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      trailing: InkWell(
                        onTap: () {
                          toggleStatus(snapshot.data![index].id.toString());
                        },
                        child: Chip(
                            label: snapshot.data![index].status == 'pending'
                                ? Text('Accepted')
                                : Text('Accept'),
                            backgroundColor:
                                snapshot.data![index].status == 'pending'
                                    ? Colors.green
                                    : Colors.amber),
                      ),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product: ${snapshot.data![index].product1}'),
                          Text('Address: ${snapshot.data![index].address}'),
                          Text('Pin: ${snapshot.data![index].pincode}'),
                        ],
                      ),
                      // leading: CircleAvatar(),
                      title: Text(snapshot.data![index].customerName),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
