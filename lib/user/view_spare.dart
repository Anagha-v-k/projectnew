import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:vehicleassistant/Models/sparemodel.dart';
import 'package:vehicleassistant/constants/constant_data.dart';
import 'package:vehicleassistant/user/single_product.dart';

class ViewSpare extends StatelessWidget {
  const ViewSpare({Key? key}) : super(key: key);

  Future<List<SpareViewModel>> getSpares() async {
    //complete below code to view spare parts
    Response res = await get(Uri.parse(ConstantData.baseUrl + 'spare_view'));
    final List data = jsonDecode(res.body);
    List<SpareViewModel> spare =
        data.map<SpareViewModel>((e) => SpareViewModel.fromJson(e)).toList();

    return spare;
  }

//code for spare parts request
  request(BuildContext context) async {
    Response res = await post(Uri.parse(ConstantData.baseUrl + ''));
    //if success
    Fluttertoast.showToast(msg: 'failed');
    //else
    Fluttertoast.showToast(msg: 'request send');
  }

  @override
  Widget build(BuildContext context) {
    //complete the body
    return Scaffold(
      body: FutureBuilder(
          future: getSpares(),
          builder: (context, AsyncSnapshot<List<SpareViewModel>> snap) {
            if (!snap.hasData) {
              return Center(
                child: Text('No data'),
              );
            } else {
              return GridView.builder(
                  itemCount: snap.data?.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleProduct(
                                    spareViewModel:
                                        snap.data!.elementAt(index)),
                              ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[100],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Hero(
                                  tag:
                                      "${snap.data?.elementAt(index).workshop}",
                                  child: Image.network(
                                    ConstantData.imgBaseUrl +
                                        "${snap.data!.elementAt(index).image}",
                                    height: 150,
                                    width: 100,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20 / 4),
                              child: Text(
                                'name : ${snap.data!.elementAt(index).name.toString()}',
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20 / 4),
                              child: Text(
                                'price : ${snap.data!.elementAt(index).price.toString()}Rs',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
