import 'package:speedy_chow/features/payment_method/domain/enitites/razorpay_order_id.dart';

class RazorpayOrderIdModel extends RazorpayOrderId{

  RazorpayOrderIdModel({required super.orderId, required super.entity,required super.status, required super.amount, required super.amountDue, required super.amountPaid, required super.otherDetails, required super.createdAt});

  factory RazorpayOrderIdModel.fromJson(Map<String,dynamic> json){
    return RazorpayOrderIdModel(
        orderId: json['id'] ??"",
        entity: json["entity"] ??"",
        status: json["status"] ??"",
        amount: json['amount']??0 ,
        amountDue: json['amount_due'] ??0,
        amountPaid: json['amount_paid'] ??0,
        createdAt: json['created_at']??0,
        otherDetails:json['notes']??{}
    );
  }

  static RazorpayOrderIdModel createResponseModel(Map<String,dynamic> json){
    return RazorpayOrderIdModel.fromJson(json);
  }

}