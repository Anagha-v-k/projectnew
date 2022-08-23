import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/sparemodel.dart';
import '../constants/constant_data.dart';

class SingleProduct extends StatefulWidget {
  const SingleProduct({Key? key, required this.spareViewModel})
      : super(key: key);
  final SpareViewModel spareViewModel;
  @override
  State<SingleProduct> createState() => _SingleProductState();
}

TextEditingController addressController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController pinController = TextEditingController();

class _SingleProductState extends State<SingleProduct> {
  orderForm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delivery details'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'textfield is empty';
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Customer name')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'textfield is empty';
                      }
                    },
                    minLines: 4,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text(' Address')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: pinController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'textfield is empty';
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text('pin code')),
                  ),
                ),
                ElevatedButton(
                    onPressed: placeOrder, child: Text('Place order'))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Hero(
          tag: widget.spareViewModel.workshop!,
          child: Image.network(
            ConstantData.imgBaseUrl + "${widget.spareViewModel.image}",
            width: double.infinity,
          ),
        ),
        Text(
          widget.spareViewModel.name.toString().toUpperCase(),
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
        ),
        Text(
          "Model Name : ${widget.spareViewModel.vehicleModel.toString().toUpperCase()}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        // CounterWithPrice(price: widget.spareViewModel),
        Text('Price : ₹${widget.spareViewModel.price!}'),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  orderForm();
                },
                child: Text("Buy Now"),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }

  placeOrder() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    final parm = {
      'product': widget.spareViewModel.id.toString(),
      'customer': spref.get('userid'),
      'address': addressController.text,
      'pincode': pinController.text,
      'customer_name': nameController.text,
      'status': '0',
    };
    Response res = await post(
        Uri.parse(ConstantData.baseUrl + 'addsparerequest'),
        body: parm);
    final x = int.tryParse(jsonDecode(res.body)['product'].toString());
    if (x == null) {
      Fluttertoast.showToast(msg: '$parm');
    } else {
      Fluttertoast.showToast(msg: 'Success');
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
    print(res.body);
  }
}
