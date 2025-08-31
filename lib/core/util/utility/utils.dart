import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:speedy_chow/features/cart/domain/enitites/cart.dart';

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

int calTotalPrice(List<Cart> items){

  if(items.isEmpty){return 0;}

  int price=0;
  for(int i=0;i<items.length;i++){
    price+=items[i].quantity! * items[i].product!.discountedPrice!;
  }
  return price;
}

String getProperDate(String? time){
  if(time!=null &&  time.isNotEmpty){
    DateTime dateTime=DateTime.parse(time).toLocal();
    return DateFormat('dd/MMM/yyyy').format(dateTime);
  }else{
    return "";
  }
}
