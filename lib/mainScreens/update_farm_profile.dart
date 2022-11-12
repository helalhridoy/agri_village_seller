import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;
import 'package:flutter/material.dart';
import 'package:agrivillage_sellers_app/mainScreens/farm_profile.dart';
import 'package:agrivillage_sellers_app/model/farm.dart';
import 'package:agrivillage_sellers_app/widgets/error_dialog.dart';
import 'package:image_picker/image_picker.dart';

import '../global/global.dart';
import '../widgets/progress_bar.dart';

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
  TextEditingController farmName = TextEditingController();
  TextEditingController farmAddress = TextEditingController();
  TextEditingController farmDetails = TextEditingController();
  TextEditingController farmFeatures = TextEditingController();
  TextEditingController farmTiming = TextEditingController();
  TextEditingController farmRules = TextEditingController();
  TextEditingController farmCharges = TextEditingController();

  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool uploading = false;
  bool start = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
  //FirebaseStorage _storage = FirebaseStorage.instance;

  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.amber,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text(
          "Add New Items",
          style: TextStyle(fontSize: 30, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => const farm_profile()));
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.cyan,
            Colors.amber,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shop_two,
                color: Colors.white,
                size: 200.0,
              ),
              ElevatedButton(
                child: const Text(
                  "Update Profile Info Item",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    start = true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  upload_farm_details() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.amber,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text(
          "Updating Farm Details",
          style: TextStyle(fontSize: 20, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            clearMenusUploadForm();
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => const farm_profile()));
          },
        ),
        actions: [
          TextButton(
            child: const Text(
              "Add",
              style: TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: "Varela",
                letterSpacing: 3,
              ),
            ),
            onPressed: () {
              validateUploadForm();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              uploading == true ? linearProgress() : const Text(""),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    controller: farmName,
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
                    controller: farmAddress,
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
                    controller: farmDetails,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Farm Details',
                      hintText: 'Enter Details',
                      prefixIcon: Icon(Icons.home),
                      border: OutlineInputBorder(),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: farmFeatures,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Features',
                    hintText: 'Enter your Features',
                    prefixIcon: Icon(Icons.pan_tool_sharp),
                    border: OutlineInputBorder(),
                  ),
                  //minLines: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: farmTiming,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Opening Closing Time',
                    hintText: 'Enter your Timing',
                    prefixIcon: Icon(Icons.pan_tool_sharp),
                    border: OutlineInputBorder(),
                  ),
                  //minLines: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: farmRules,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Rulse For Visitors',
                    hintText: 'Enter your Rules to visit',
                    prefixIcon: Icon(Icons.pan_tool_sharp),
                    border: OutlineInputBorder(),
                  ),
                  //minLines: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: farmCharges,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Charge to Visit',
                    hintText: 'Enter your Charge to visit',
                    prefixIcon: Icon(Icons.pan_tool_sharp),
                    border: OutlineInputBorder(),
                  ),
                  //minLines: 2,
                ),
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
                      child: const Text('Select Image 2 Files For Slider'),
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
                      child: const Text('Select Image 3 Files For Slider'),
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
                      child: const Text('Select Image 4 Files For Slider'),
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
                      child: const Text('Select Image 5 Files For Slider'),
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
      farmName.clear();
      farmAddress.clear();
      farmFeatures.clear();
      farmDetails.clear();
      farmTiming.clear();
      farmRules.clear();
      farmCharges.clear();

      imageXFile = null;
    });
  }

  validateUploadForm() async {
    if (selectedImage.isNotEmpty) {
      if (farmName.text.isNotEmpty &&
          farmAddress.text.isNotEmpty &&
          farmFeatures.text.isNotEmpty &&
          farmDetails.text.isNotEmpty &&
          farmTiming.text.isNotEmpty &&
          farmRules.text.isNotEmpty &&
          farmCharges.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });

        //upload image
        List<String> url = [];
        for (int i = 0; i < selectedImage.length; i++) {
          String downloadUrl = await uploadImage(File(selectedImage[i].path));
          url.add(downloadUrl);
        }

        //save info to firestore
        saveInfo(url);
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "Please write title and info for farm Details.",
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please pick all images for slider.",
            );
          });
    }
  }

  saveInfo(List<String> url) {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("firmVisit");

    ref.doc("farmDetails").set({
      "farmName": farmName.text.toString(),
      "farmAddress": farmAddress.text.toString(),
      "farmDetails": farmDetails.text.toString(),
      "farmFeatures": farmFeatures.text.toString(),
      "farmTiming": farmTiming.text.toString(),
      "farmRules": farmRules.text.toString(),
      "farmCharges": farmCharges.text.toString(),
      "sellerUID": sharedPreferences!.getString("uid"),
      "sellerName": sharedPreferences!.getString("name"),
      "title": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "s_img1": url[0],
      "s_img2": url[1],
      "s_img3": url[2],
      "s_img4": url[3],
      "s_img5": url[4],
    }).then((value) {
      final itemsRef = FirebaseFirestore.instance.collection("firmVisit");

      itemsRef.doc("farmDetails").set({
        "farmName": farmName.text.toString(),
        "farmAddress": farmAddress.text.toString(),
        "farmDetails": farmDetails.text.toString(),
        "farmFeatures": farmFeatures.text.toString(),
        "farmTiming": farmTiming.text.toString(),
        "farmRules": farmRules.text.toString(),
        "farmCharges": farmCharges.text.toString(),
        "sellerUID": sharedPreferences!.getString("uid"),
        "sellerName": sharedPreferences!.getString("name"),
        "title": titleController.text.toString(),
        "publishedDate": DateTime.now(),
        "status": "available",
        "s_img1": url[0],
        "s_img2": url[1],
        "s_img3": url[2],
        "s_img4": url[3],
        "s_img5": url[4],
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

  @override
  Widget build(BuildContext context) {
    return start == false ? defaultScreen() : upload_farm_details();
  }
}
