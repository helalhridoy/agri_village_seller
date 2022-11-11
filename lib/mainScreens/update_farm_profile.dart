import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;
import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/model/farm.dart';
import 'package:image_picker/image_picker.dart';

import '../global/global.dart';
import '../widgets/my_drawer.dart';

class update_farm_profile extends StatefulWidget {
  const update_farm_profile({Key? key, this.model}) : super(key: key);
  final Menus? model;

  @override
  State<update_farm_profile> createState() => _update_farm_profileState();
}

class _update_farm_profileState extends State<update_farm_profile> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImage = [];

  XFile? imageXFile;
  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
  //FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.green,
        ),
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(fontSize: 30, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: const [],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Farm Name',
                      hintText: 'Enter Farm Name',
                      prefixIcon: Icon(Icons.drive_file_rename_outline),
                      border: OutlineInputBorder(),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Farm Address',
                      hintText: 'Enter Address',
                      prefixIcon: Icon(Icons.home),
                      border: OutlineInputBorder(),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Features',
                    hintText: 'Enter your Features',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    border: OutlineInputBorder(),
                  ),
                  //minLines: 2,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Open Timing',
                      hintText: 'Enter your timing',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      border: OutlineInputBorder(),
                    )),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        selectImage(1);
                      },
                      child: const Text('Select Image 1 Files For Slider'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: selectedImage.length >= 2
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  File(selectedImage[0].path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("No image"),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        selectImage(2);
                      },
                      child: const Text('Select Image Files For Slider'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: selectedImage.length >= 2
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  File(selectedImage[1].path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("No image"),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        selectImage(3);
                      },
                      child: const Text('Select Image Files For Slider'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: selectedImage.length >= 3
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  File(selectedImage[2].path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("No image"),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        selectImage(4);
                      },
                      child: const Text('Select Image Files For Slider'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: selectedImage.length >= 4
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  File(selectedImage[3].path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("No image"),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        selectImage(5);
                      },
                      child: const Text('Select Image Files For Slider'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: selectedImage.length >= 5
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  File(selectedImage[4].path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("No image"),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectImage(int i) async {
    try {
      if (selectedImage.length >= i) {
        XFile? img = await _picker.pickImage(source: ImageSource.gallery);
        selectedImage[i - 1] = img!;
      } else {
        XFile? img = await _picker.pickImage(source: ImageSource.gallery);
        selectedImage.add(img!);
      }
    } catch (e) {
      print("Something went wrong" + e.toString());
    }
    setState(() {});
  }

  clearMenusUploadForm() {
    setState(() {
      shortInfoController.clear();
      titleController.clear();
      priceController.clear();
      descriptionController.clear();

      imageXFile = null;
    });
  }

  saveInfo(String downloadUrl) {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.sellerUID)
        .collection("items");

    ref.doc(uniqueIdName).set({
      "itemID": uniqueIdName,
      "menuID": widget.model!.sellerUID,
      "sellerUID": sharedPreferences!.getString("uid"),
      "sellerName": sharedPreferences!.getString("name"),
      "shortInfo": shortInfoController.text.toString(),
      "longDescription": descriptionController.text.toString(),
      "price": int.parse(priceController.text),
      "title": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
    }).then((value) {
      final itemsRef = FirebaseFirestore.instance.collection("items");

      itemsRef.doc(uniqueIdName).set({
        "itemID": uniqueIdName,
        "menuID": widget.model!.sellerUID,
        "sellerUID": sharedPreferences!.getString("uid"),
        "sellerName": sharedPreferences!.getString("name"),
        "shortInfo": shortInfoController.text.toString(),
        "longDescription": descriptionController.text.toString(),
        "price": int.parse(priceController.text),
        "title": titleController.text.toString(),
        "publishedDate": DateTime.now(),
        "status": "available",
        "thumbnailUrl": downloadUrl,
      });
    }).then((value) {
      clearMenusUploadForm();

      setState(() {
        uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
        uploading = false;
      });
    });
  }

  uploadImage(mImageFile) async {
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child("items");

    storageRef.UploadTask uploadTask =
        reference.child(uniqueIdName + ".jpg").putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }
}
