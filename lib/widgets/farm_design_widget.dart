import 'package:agrivillage_sellers_app/mainScreens/farm_profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

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
  final images = [];
  bool initState() {
    images.add(widget.model!.s_img2!);
    images.add(widget.model!.s_img3!);
    images.add(widget.model!.s_img4!);
    images.add(widget.model!.s_img5!);
    return true;
  }

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
