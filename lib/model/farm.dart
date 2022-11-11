import 'package:cloud_firestore/cloud_firestore.dart';

class Menus {
  String? sellerName;
  String? sellerUID;
  String? farmName;
  String? farmAddress;
  Timestamp? publishedDate;
  String? farmDetails;
  String? farmFeatures;
  String? farmTiming;
  String? farmRules;
  String? farmCharges;
  String? thumbnailUrl1;
  String? thumbnailUrl2;
  String? thumbnailUrl3;
  String? thumbnailUrl4;
  String? thumbnailUrl5;
  String? status;

  Menus({
    this.sellerName,
    this.sellerUID,
    this.farmName,
    this.farmAddress,
    this.publishedDate,
    this.farmDetails,
    this.farmFeatures,
    this.farmTiming,
    this.farmRules,
    this.farmCharges,
    this.thumbnailUrl1,
    this.thumbnailUrl2,
    this.thumbnailUrl3,
    this.thumbnailUrl4,
    this.thumbnailUrl5,
    this.status,
  });

  Menus.fromJson(Map<String, dynamic> json) {
    sellerName = json['sellerName'];
    sellerUID = json['sellerUID'];
    farmName = json['farmName'];
    farmAddress = json['farmLocation'];
    publishedDate = json['publishedDate'];
    farmDetails = json['farmDetails'];
    farmFeatures = json['farmFeatures'];
    farmTiming = json['farmTiming'];
    farmRules = json['farmRules'];
    farmCharges = json['farmCharges'];
    thumbnailUrl1 = json['thumbnailUrl1'];
    thumbnailUrl2 = json['thumbnailUrl2'];
    thumbnailUrl3 = json['thumbnailUrl3'];
    thumbnailUrl4 = json['thumbnailUrl4'];
    thumbnailUrl5 = json['thumbnailUrl5'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['sellerName'] = sellerName;
    data['sellerUID'] = sellerUID;
    data['farmName'] = farmName;
    data['farmLocation'] = farmAddress;
    data['publishedDate'] = publishedDate;
    data['farmDetails'] = farmDetails;
    data['farmFeatures'] = farmFeatures;
    data['farmTiming'] = farmTiming;
    data['farmRules'] = farmRules;
    data['farmCharges'] = farmCharges;
    data['thumbnailUrl1'] = thumbnailUrl1;
    data['thumbnailUrl2'] = thumbnailUrl2;
    data['thumbnailUrl3'] = thumbnailUrl3;
    data['thumbnailUrl4'] = thumbnailUrl4;
    data['thumbnailUrl5'] = thumbnailUrl5;
    data['status'] = status;
    return data;
  }
}
