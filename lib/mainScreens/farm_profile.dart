import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/mainScreens/update_farm_profile.dart';

import '../global/global.dart';
import '../widgets/my_drawer.dart';

class farm_profile extends StatefulWidget {
  const farm_profile({Key? key}) : super(key: key);

  @override
  State<farm_profile> createState() => _farm_profileState();
}

class _farm_profileState extends State<farm_profile> {
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
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const update_farm_profile()));
            },
            child: Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
