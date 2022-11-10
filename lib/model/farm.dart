import 'package:cloud_firestore/cloud_firestore.dart';

class Menus {
  String? sellerUID;
  String? farmName;
  String? farmLocation;
  Timestamp? publishedDate;
  String? farmDetails;
  String? farmFeatures;
  String? farmTiming;
  String? thumbnailUrl1;
  String? thumbnailUrl2;
  String? thumbnailUrl3;
  String? thumbnailUrl4;
  String? thumbnailUrl5;
  String? thumbnailUrl6;
  String? status;

  Menus({
    this.sellerUID,
    this.farmName,
    this.farmLocation,
    this.publishedDate,
    this.farmDetails,
    this.farmFeatures,
    this.farmTiming,
    this.thumbnailUrl1,
    this.thumbnailUrl2,
    this.thumbnailUrl3,
    this.thumbnailUrl4,
    this.thumbnailUrl5,
    this.thumbnailUrl6,
    this.status,
  });

  Menus.fromJson(Map<String, dynamic> json) {
    sellerUID = json['sellerUID'];
    farmName = json['farmName'];
    farmLocation = json['farmLocation'];
    publishedDate = json['publishedDate'];
    farmDetails = json['farmDetails'];
    farmFeatures = json['farmFeatures'];
    farmTiming = json['farmTiming'];
    thumbnailUrl1 = json['thumbnailUrl1'];
    thumbnailUrl2 = json['thumbnailUrl2'];
    thumbnailUrl3 = json['thumbnailUrl3'];
    thumbnailUrl4 = json['thumbnailUrl4'];
    thumbnailUrl5 = json['thumbnailUrl5'];
    thumbnailUrl6 = json['thumbnailUrl6'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['sellerUID'] = sellerUID;
    data['farmName'] = farmName;
    data['farmLocation'] = farmLocation;
    data['publishedDate'] = publishedDate;
    data['farmDetails'] = farmDetails;
    data['farmFeatures'] = farmFeatures;
    data['farmTiming'] = farmTiming;
    data['thumbnailUrl1'] = thumbnailUrl1;
    data['thumbnailUrl2'] = thumbnailUrl2;
    data['thumbnailUrl3'] = thumbnailUrl3;
    data['thumbnailUrl4'] = thumbnailUrl4;
    data['thumbnailUrl5'] = thumbnailUrl5;
    data['thumbnailUrl6'] = thumbnailUrl6;
    data['status'] = status;
    return data;
  }
}
