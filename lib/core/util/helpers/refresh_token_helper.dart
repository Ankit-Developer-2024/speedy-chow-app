import 'package:dio/src/response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_manager.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';

class RefreshTokenHelper{
 static Future<void> refresh()async{
   try{
     Response response=await DioManager.httpDio.get(AppUrl.refresh);
   }catch(err){
     print("---------------token $err");
   }
 }
}