import 'dart:io';

import 'package:agrivillage_sellers_app/mainScreens/farm_profile.dart';
import 'package:agrivillage_sellers_app/model/farm.dart';
import 'package:agrivillage_sellers_app/widgets/error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../global/global.dart';
import '../widgets/progress_bar.dart';

class update_farm_profile extends StatefulWidget {
  const update_farm_profile({Key? key, this.model}) : super(key: key);
  final Farm? model;

  @override
  State<update_farm_profile> createState() => _update_farm_profileState();
}

class _update_farm_profileState extends State<update_farm_profile> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImage = [];

  Position? position;
  List<Placemark>? placeMarks;


  String sellerImageUrl = "";
  String completeAddress = "";
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
  double lat=23.7397;
  double lng=90.3943;
  String address="";
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  //FirebaseStorage _storage = FirebaseStorage.instance;

  getCurrentLocation() async {
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );

    position = newPosition;

    placeMarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );
    lat= position!.latitude;
    lng=position!.longitude;
    print("latitude");
    print(position!.latitude);
    print("longitude");
    print(position!.longitude);
    Placemark pMark = placeMarks![0];

    completeAddress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

    farmAddress.text = completeAddress;
  }

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
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => farm_profile()));
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
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => farm_profile()));
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
              Container(
                width: 400,
                height: 40,
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  label: const Text(
                    "Get my Current Location",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    getCurrentLocation();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Container(
                width: 400,
                height: 300,
                alignment: Alignment.center,
                child: OpenStreetMapSearchAndPick(
                    center: LatLong(lat, lng),
                    buttonColor: Colors.blue,
                    buttonText: 'Set Current Location',
                    onPicked: (pickedData) {
                      print(pickedData.latLong.latitude);
                      print(pickedData.latLong.longitude);
                      print(pickedData.address);

                      address=pickedData.address;
                      farmAddress.text = address;
                      lat=pickedData.latLong.latitude;
                      lng=pickedData.latLong.longitude;
                    })
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
                        child: selectedImage.length >= 1
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
                      child: const Text('Select 5 Image Files For Slider'),
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

        setState(() {
          selectedImage[i - 1] = img!;
        });
      } else {
        XFile? img = await _picker.pickImage(source: ImageSource.gallery);
        setState(() {
          selectedImage.add(img!);
        });
      }
    } catch (e) {
      print("Something went wrong" + e.toString());
    }
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

        url.add(await uploadImage(File(selectedImage[0].path), 0));
        url.add(await uploadImage(File(selectedImage[1].path), 1));
        url.add(await uploadImage(File(selectedImage[2].path), 2));
        url.add(await uploadImage(File(selectedImage[3].path), 3));
        url.add(await uploadImage(File(selectedImage[4].path), 4));

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
      "lat": lat,
      "lng": lng,
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
      final itemsRef = FirebaseFirestore.instance
          .collection("sellers")
          .doc(sharedPreferences!.getString("uid"))
          .collection("firmVisit");

      itemsRef.doc("farmDetails").set({
        "farmName": farmName.text.toString(),
        "farmAddress": farmAddress.text.toString(),
        "lat": lat,
        "lng": lng,
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

  uploadImage(mImageFile, int i) async {
    storageRef.Reference reference = storageRef.FirebaseStorage.instance
        .ref()
        .child("sellers")
        .child("sliders");

    storageRef.UploadTask uploadTask = reference
        .child(uniqueIdName + i.toString() + ".jpg")
        .putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return start == false ? defaultScreen() : upload_farm_details();
  }
}
