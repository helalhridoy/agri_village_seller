import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../global/global.dart';
import '../widgets/my_drawer.dart';

class update_farm_profile extends StatefulWidget {
  const update_farm_profile({Key? key}) : super(key: key);

  @override
  State<update_farm_profile> createState() => _update_farm_profileState();
}

class _update_farm_profileState extends State<update_farm_profile> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFiles = [];
  FirebaseStorage _storage = FirebaseStorage.instance;

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
        actions: [],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            OutlinedButton(
              onPressed: () {
                selectImage();
              },
              child: Text('Select Image Files For Slider'),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.file_upload),
              onPressed: () {},
              label: Text(
                "Upload",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            _selectedFiles.length == 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text("No image Selected"),
                  )
                : Expanded(
                    child: GridView.builder(
                        itemCount: _selectedFiles.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.file(
                              File(_selectedFiles[index].path),
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }

  Future<void> selectImage() async {
    if (_selectedFiles != null) {
      _selectedFiles.clear();
    }
    try {
      final List<XFile>? imgs = await _picker.pickMultiImage();
      if (imgs!.isNotEmpty) {
        _selectedFiles.addAll(imgs);
      }
      print("number of selected images: " + _selectedFiles.length.toString());
    } catch (e) {
      print("Something went wrong" + e.toString());
    }
    setState(() {});
  }
}
