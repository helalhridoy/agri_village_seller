import 'package:cloud_firestore/cloud_firestore.dart';

class Farm {
  String? sellerName;
  String? sellerUID;
  String? farmName;
  String? farmAddress;
  double? lat;
  double? lng;
  Timestamp? publishedDate;
  String? farmDetails;
  String? farmFeatures;
  String? farmTiming;
  String? farmRules;
  String? farmCharges;
  String? s_img1;
  String? s_img2;
  String? s_img3;
  String? s_img4;
  String? s_img5;
  String? status;

  Farm({
    this.sellerName,
    this.sellerUID,
    this.farmName,
    this.farmAddress,
    this.lat,
    this.lng,
    this.publishedDate,
    this.farmDetails,
    this.farmFeatures,
    this.farmTiming,
    this.farmRules,
    this.farmCharges,
    this.s_img1,
    this.s_img2,
    this.s_img3,
    this.s_img4,
    this.s_img5,
    this.status,
  });

  Farm.fromJson(Map<String, dynamic> json) {
    sellerName = json['sellerName'];
    sellerUID = json['sellerUID'];
    farmName = json['farmName'];
    farmAddress = json['farmAddress'];
    lat = json['lat'];
    lng = json['lng'];
    publishedDate = json['publishedDate'];
    farmDetails = json['farmDetails'];
    farmFeatures = json['farmFeatures'];
    farmTiming = json['farmTiming'];
    farmRules = json['farmRules'];
    farmCharges = json['farmCharges'];
    s_img1 = json['s_img1'];
    s_img2 = json['s_img2'];
    s_img3 = json['s_img3'];
    s_img4 = json['s_img4'];
    s_img5 = json['s_img5'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['sellerName'] = sellerName;
    data['sellerUID'] = sellerUID;
    data['farmName'] = farmName;
    data['farmAddress'] = farmAddress;
    data['lat'] = lat;
    data['lng'] = lng;
    data['publishedDate'] = publishedDate;
    data['farmDetails'] = farmDetails;
    data['farmFeatures'] = farmFeatures;
    data['farmTiming'] = farmTiming;
    data['farmRules'] = farmRules;
    data['farmCharges'] = farmCharges;
    data['s_img1'] = s_img1;
    data['s_img2'] = s_img2;
    data['s_img3'] = s_img3;
    data['s_img4'] = s_img4;
    data['s_img5'] = s_img5;
    data['status'] = status;
    return data;
  }
}
