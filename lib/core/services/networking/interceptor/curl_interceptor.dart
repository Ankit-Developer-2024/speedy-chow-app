
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class CurlInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options,RequestInterceptorHandler handler){
    try{
       final qp=options.queryParameters;
       final h=options.headers;
       final d=options.data;
       final curl='curl -X ${options.method} \'${options.baseUrl}${options.path}${qp.isNotEmpty ? qp.keys.fold('', (value, key) => '$value${value.isEmpty ? '?' : '&'}$key=${qp[key]}\'') : '\''}${h.keys.fold('', (value, key) => '$value -H \'$key: ${h[key]}\'')}${d!= null&&d.length != 0 ? ' --data-binary \'$d\'' : ''} --insecure';
       debugPrint("======>>>>><<<<<======");
       log(curl);
       appLog(curl);
       debugPrint("======>>>>><<<<<======");
    }catch(e){
      debugPrint('CurlInterceptor error: $e');
    }
    super.onRequest(options, handler);
  }


   @override
   void onError(DioException err,ErrorInterceptorHandler handler) async{
       try{
           final qp=err.requestOptions.queryParameters;
           final h = err.requestOptions.headers;
           final d = err.requestOptions.data;
           final options = err.requestOptions;
           final curl =
               'curl -X ${options.method} \'${options.baseUrl}${options.path}${qp.isNotEmpty ? qp.keys.fold('', (value, key) => '$value${value.isEmpty ? '?\'' : '&'}$key=${qp[key]}\'') : '\''}${h.keys.fold('', (value, key) => '$value -H \'$key: ${h[key]}\'')}${d!= null&&d.length != 0 ? ' --data-binary \'$d\'' : ''} --insecure';
           debugPrint("======>>>>><<<<<======");
           appLog(curl);
           debugPrint("======>>>>><<<<<======");
       }catch(e){
         debugPrint('CurlInterceptor error: $e');
       }

   }

}