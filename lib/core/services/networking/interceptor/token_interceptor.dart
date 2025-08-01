 import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_manager.dart';
import 'package:speedy_chow/core/services/preferences/app_secure_storage.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/core/util/helpers/refresh_token_helper.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class TokenInterceptor implements Interceptor{
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async{
   try{
     if(err.response?.statusCode==401){
       await RefreshTokenHelper.refresh();
       String? newAccessToken=await AppSecureStorage.instance.getAccessToken();
       if(newAccessToken!=null && newAccessToken.isNotEmpty){
         DioManager.httpDio.options.headers["Authorization"] = "Bearer $newAccessToken";
          print("===================================tokrn itercept");
         // Retry the failed request
         final RequestOptions options = err.requestOptions;
         final retryResponse = await DioManager.httpDio.request(
           options.path,
           data: options.data,
           queryParameters: options.queryParameters,
           options: Options(
             method: options.method,
             headers: options.headers,
           ),
         );
         return handler.resolve(retryResponse);
       }
       return handler.next(err);
     }
   }catch(err){
     print("on error token-----$err");
     debugPrint('TokenInterceptor error: $err');
   }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
      try{
        if(options.path==AppUrl.verify){
          String? refreshToken=  await AppSecureStorage.instance.getRefreshToken();
          if(refreshToken!=null && refreshToken.isNotEmpty){
            options.headers["authorization"]="Bearer $refreshToken";
          }

          handler.next(options);
        }else{
          String? accessToken=  await AppSecureStorage.instance.getAccessToken();
          if(accessToken!=null && accessToken.isNotEmpty){
            options.headers["authorization"]="Bearer $accessToken";
          }

          handler.next(options);
        }

      }catch(err){
        debugPrint('TokenInterceptor error: $err');
      }

  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
   try{
     String? accessToken=  response.data["accessToken"];
     String? refreshToken=  response.data["refreshToken"];
     if(accessToken!=null){
       AppSecureStorage.instance.saveAccessToken(accessToken: accessToken);
       appLog("<-accessToken-> Save");
     }
     if(refreshToken!=null){
       AppSecureStorage.instance.saveRefreshToken(refreshToken: refreshToken);
       appLog("<-refreshToken-> Save");

     }
     handler.next(response);
   }catch(err){
     debugPrint('TokenInterceptor error: $err');
   }
  }

}