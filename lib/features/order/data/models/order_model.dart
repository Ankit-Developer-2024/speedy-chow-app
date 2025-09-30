import 'package:speedy_chow/core/components/models/address_model.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/features/cart/data/models/cart_model.dart';
import 'package:speedy_chow/features/order/domain/entities/order.dart';

class OrderModel extends Order{
  OrderModel({
    required super.id,
    required super.items,
    required super.totalAmount,
    required super.totalItems,
    required super.paymentMethod,
    required super.status,
    required super.statusReason,
    required super.address
  });

  factory OrderModel.fromJson(Map<String,dynamic> json){
    return OrderModel(
      id: json['id'] ?? "",
      items: json['items'] !=null ? (json['items'] as List).map((item)=> CartModel.createResponseModel(item)).toList() : [],
      totalAmount: json["totalAmount"]??0,
      totalItems: json["totalItems"]??0,
      paymentMethod: json["paymentMethod"] ??"",
      status: _createOrderStatus(json['status']) ,
      statusReason:  json['statusReason'] ??"" ,
      address: json['selectedAddress']!=null ? AddressModel.fromJson(json['selectedAddress']):null,
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'items':items?.map((item)=>(item as CartModel).toJson()).toList() ,
      'totalAmount':totalAmount,
      'totalItems':totalItems,
      'paymentMethod':paymentMethod,
      'selectedAddress': (address as AddressModel).toJson()

    };
  }

  static List<OrderModel> createResponseModelWithList(List<dynamic> json){
    List<OrderModel> orderModels=(json).map((item)=>OrderModel.fromJson(item)).toList();
    return orderModels;
  }


  static OrderModel createResponseModel(Map<String,dynamic> json){
    return OrderModel.fromJson(json);
  }

 static OrderStatus _createOrderStatus(String? status){
    switch(status){
      case "Order Confirmed":
        return OrderStatus.orderedConfirmed;
      case "Preparing Food":
        return OrderStatus.preparingFood;
      case "Out For Delivery":
        return OrderStatus.outForDelivery;
      case "Delivered":
        return OrderStatus.delivered;
      case "Cancelled":
        return OrderStatus.cancelled;
      default:
        return OrderStatus.cancelled;
    }
  }

}