import 'package:flutter/foundation.dart';

String getLocalJpeg(String imgName){
  return "assets/jpeg_and_jpg/$imgName.jpeg";
}

String getLocalJpg(String imgName){
  return "assets/jpeg_and_jpg/$imgName.jpg";
}

String getLocalPng(String imgName){
  return "assets/png/$imgName.png";
}


String getLocalSvg(String imgName){
  return "assets/svg/$imgName.svg";
}

void appLog(dynamic text){
  if(kDebugMode) debugPrint(text?.toString());
}

int discountPrice(int price , int discountPercentage){
  return (price-(price*(discountPercentage/100))).round();
}
