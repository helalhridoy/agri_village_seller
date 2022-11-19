import 'package:agrivillage_sellers_app/mainScreens/farm_profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:map_launcher/map_launcher.dart';

import '../model/farm.dart';

class farm_design_widget extends StatefulWidget {
  //const farm_design_widget({Key? key}) : super(key: key);

  Farm? model;
  BuildContext? context;

  farm_design_widget({Key? key, this.model, this.context}) : super(key: key);

  @override
  State<farm_design_widget> createState() => _farm_design_widgetState();
}

class _farm_design_widgetState extends State<farm_design_widget> {
  @override
  final images = [];
  bool initState() {
    super.initState();

    focusNode = FocusNode();
    String intent = widget.model!.farmName!;
    images.add(widget.model!.s_img2!);
    images.add(widget.model!.s_img3!);
    images.add(widget.model!.s_img4!);
    images.add(widget.model!.s_img5!);
    return true;
  }

  FocusNode? focusNode;

  @override
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => farm_profile()));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          //height: 280,
          //width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              CarouselSlider(
                  items: [
                    //1st Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.model!.s_img1!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //2nd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.model!.s_img2!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //3rd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.model!.s_img3!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //4th Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.model!.s_img4!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //5th Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.model!.s_img5!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
//                    onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  )),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 40,
                width: double.maxFinite,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    widget.model!.farmName!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GFListTile(
                titleText: "FarmDetails:",
                subTitleText: widget.model!.farmDetails!,
              ),
              GFListTile(
                titleText: "Farm Features:  ",
                subTitleText: widget.model!.farmFeatures!,
              ),
              GFListTile(
                titleText: "Farm Rules :",
                subTitleText: widget.model!.farmRules!,
              ),
              GFListTile(
                titleText: "Farm Address:  ",
                subTitleText: widget.model!.farmAddress!,
              ),
              Container(
                width: 400,
                height: 40,
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  label: const Text(
                    "Open location in Map",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (await MapLauncher.isMapAvailable(MapType.google) ??
                        false) {
                      await MapLauncher.showMarker(
                        mapType: MapType.google,
                        coords: Coords(widget.model!.lat!, widget.model!.lng!),
                        title: widget.model!.farmName.toString(),
                        description: widget.model!.farmDetails,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              GFListTile(
                titleText: "Visiting Hour:",
                subTitleText: widget.model!.farmTiming!,
              ),
              GFListTile(
                titleText: "Farm Charges:",
                subTitleText: widget.model!.farmCharges!,
              ),
              GFListTile(
                titleText: "Farm Status:",
                subTitleText: widget.model!.status!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
