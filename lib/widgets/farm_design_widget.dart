import 'package:agrivillage_sellers_app/mainScreens/farm_profile.dart';
import 'package:flutter/material.dart';

import '../model/farm.dart';

class farm_design_widget extends StatefulWidget {
  //const farm_design_widget({Key? key}) : super(key: key);

  Farm? model;
  BuildContext? context;

  farm_design_widget({this.model, this.context});

  @override
  State<farm_design_widget> createState() => _farm_design_widgetState();
}

class _farm_design_widgetState extends State<farm_design_widget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => farm_profile(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.s_img1!,
                height: 220.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 1.0,
              ),
              Text(
                widget.model!.farmName!,
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                  fontFamily: "Train",
                ),
              ),
              Text(
                widget.model!.farmTiming!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
