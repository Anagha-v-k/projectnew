import 'dart:io';
// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleassistant/constants/constant_data.dart';
import 'package:async/src/delegate/stream.dart';
import 'package:vehicleassistant/screens/workshop/whome.dart';

class AddSpares extends StatefulWidget {
  AddSpares({Key? key}) : super(key: key);

  @override
  State<AddSpares> createState() => _AddSparesState();
}

class _AddSparesState extends State<AddSpares> {
  final nameController = TextEditingController();

  final vModelController = TextEditingController();

  final priceController = TextEditingController();

  // final nameController = TextEditingController();
  File? selectedImage;

  addSparePart() async {
    final request = MultipartRequest(
        'Post', Uri.parse(ConstantData.baseUrl + 'Spareaddapi'));
    request.files.add(MultipartFile(
        'image',
        filename: basename(selectedImage!.path),
        ByteStream(DelegatingStream.typed(selectedImage!.openRead())),
        await selectedImage!.length()));
    final sharedprfs = await SharedPreferences.getInstance();
    request.fields['workshop'] = sharedprfs.get("userid").toString();
    request.fields['name'] = nameController.text;
    request.fields['vehicle_model'] = vModelController.text;
    request.fields['price'] = priceController.text;
    var res = await request.send();
    var def = await Response.fromStream(res);
    print(def.body);
  }

  pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  final fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: fkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : NetworkImage(
                                'https://cdn2.iconfinder.com/data/icons/budicon-chroma-photography/24/camera-add-512.png')
                            as ImageProvider,
                    // child: selectedImage==null? Icon(
                    //   Icons.add_a_photo,
                    //   size: 50,
                    // ):Container(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'the field cannot be empty';
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('name')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: vModelController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'the field cannot be empty';
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('model')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: priceController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'the field cannot be empty';
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('price')),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          if (fkey.currentState!.validate()) {
            addSparePart();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Whome()));
          }
        },
        label: Text("add"),
        icon: Icon(Icons.send),
      ),
    );
  }
}
