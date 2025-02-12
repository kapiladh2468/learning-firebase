// import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  String? name;
  String? id;
  String? address;
  int? phone;
  Timestamp? establishedAt;
  List? services;

  Company({this.address,this.name,this.phone,this.establishedAt,this.services,this.id});

  toJson(){
    Map<String,dynamic> json ={};
    json['id'] =id;
    json['name'] = name;
    json['address']= address;
    json ['services']= services;
    json ['establishedAt'] =establishedAt;
    json ['phone']= phone;


return json;
  }

}