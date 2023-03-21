
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Thumbnail extends ChangeNotifier{
  List thumbnailList=[];// list of thumbnails
  //getting the thumbnail details from api 
  getThumbnail() async
  {
    final receivedDataFromJSon= await rootBundle.loadString("JSONFiles/thumbnail_data.json");
    final dataFromJson = await jsonDecode(receivedDataFromJSon);
    thumbnailList=dataFromJson;
    notifyListeners();
  }
}

/// change res to dataFromJson, datra to receivedDataFromJSon
/// JSONFiles/thumbnail_data.json store in variable file...
/// in_line documentation
/// done everything