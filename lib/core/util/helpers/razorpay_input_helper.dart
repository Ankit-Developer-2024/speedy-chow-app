import 'package:speedy_chow/core/util/config/app_secret_config.dart';

class RazorPayInputHelper{

  static Map<String,dynamic> razorPayInput({required int amount,required String orderId,required int? phoneNumber , required String? email}){
    Map<String,dynamic> options = {
      'key': AppSecretConfig.instance?.values?.rzPublicId,
      'amount': amount,
      'name': 'Speedy Chow',
      'description': 'Buy fast food from Speedy Chow!',
      "order_id": orderId,
      'retry': {'enabled': true, 'max_count': 4},
      'send_sms_hash': true,
      'prefill': {'contact': phoneNumber==null ?"" :phoneNumber.toString(), 'email': email.toString()},
    };
    return options;
  }

}