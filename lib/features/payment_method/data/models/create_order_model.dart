import 'package:speedy_chow/features/payment_method/domain/enitites/create_order.dart';

class CreateOrderModel extends CreateOrder{
  CreateOrderModel({required super.isOrderCreated});

  factory CreateOrderModel.fromJson(Map<String,dynamic> json){
    return CreateOrderModel(
      isOrderCreated: json['isOrderCreated']??false,
    );
  }

  static CreateOrderModel createResponseModel(Map<String,dynamic> json){
    return CreateOrderModel.fromJson(json);
  }

}