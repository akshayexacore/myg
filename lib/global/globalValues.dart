

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_claim/configs/app_config.dart';


class Global {

  static final Global _instance = Global._internal();

  // passes the instantiation to the _instance object
  factory Global() => _instance;

  //initialize variables in here
  Global._internal() {
    _wstrToken = '';
    _wstrempId='';
    _wstrempName='';
    _wstrempLocation='';
    // _wstrBranchList=[];
    _wstrCylinderPara=[];

  }
  var _wstrToken  = '';
  var _wstrempName ='';
  var _wstrempId ='';
  var _wstrempLocation ='';
  // var _wstrBranchList=[];
  var _wstrCylinderPara=[];





  // get wstrBranchName => _wstrBranchName;
  // set wstrBranchName(value) {
  //   _wstrBranchName = value;
  // }




  get wstrToken => _wstrToken;
  set wstrToken(value) {
    _wstrToken = value;
  }
  get wstrempLocation => _wstrempLocation;
  set wstrempLocation(value) {
    _wstrempLocation = value;
  }

  get wstrEmpId => _wstrempId;
  set wstrEmpId(value) {
    _wstrempId = value;
  }
  get wstrEmpName => _wstrempName;
  set wstrEmpName(value) {
    _wstrempName = value;
  }



  // get wstrBranchList => _wstrBranchList;
  // set wstrBranchList(value) {
  //   _wstrBranchList = value;
  // }

  bool fnValCheck(value){
    if(value == null){
      return false;
    }else{
      if(value.length > 0){
        return true;
      }else{
        return false;
      }
    }
  }

  mfnJson(arr){
    var tempArray;
    try{
      if(fnValCheck(arr)){
        String tempString = jsonEncode(arr);
        tempArray  =  jsonDecode(tempString);
      }
    }catch(e){
      tempArray = [];
    }
    return tempArray;
  }
  mfnDbltoInt(dbl){

    var lstrInt = 0;
    try {
      lstrInt =  double.parse((dbl??'0.0').toString()).toInt();
    }
    catch(e){
      lstrInt= 0;
    }
    return lstrInt;
  }

}

validCheck(String s) {
  List<String> invalid = ['+', '*', '/', ',', '(', ')', '=', '#'];
  for (String ch in invalid) {
    if (s.contains(ch)) {
      s = s.replaceAll(ch, '');
    }
  }
  return s;
}
 stringToBoolean(String booleanString) {
  switch (booleanString.toLowerCase()) {
    case 'true':
    case 'yes':
    case '1':
      return true;
    case 'false':
    case 'no':
    case '0':
      return false;
    default:
      throw FormatException("Invalid boolean string: $booleanString");
  }
}
String getFullImageUrl(String imagePath) {
  debugPrint("the image url is here $imagePath");
  // If it's already a full URL, return as is
  if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
    return imagePath;
  }
  // Otherwise, append your base URL
  return "${AppConfig.imageLiveBaseUrl}$imagePath";
}
List<String> normalizeFiles(List<String>? files) {
  if (files == null) return [];
  return files.map((file) {
      if (file.contains('/uploads/')) {
    final filePath = file.split('/uploads/').last;
      return 'uploads/$filePath';
    }
    return file;
  }).toList();
}