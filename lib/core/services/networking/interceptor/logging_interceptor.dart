

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class LoggingInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options , RequestInterceptorHandler handler){
    appLog("adding headers");
      //-----header add here
    options.headers["consignment-support"] = true;
    options.headers.putIfAbsent(Headers.contentTypeHeader, ()=>Headers.jsonContentType);
    appLog('----------headers--------------');
    appLog(options.headers.toString());
    handler.next(options);
  }

  @override
  void onResponse(Response response , ResponseInterceptorHandler handler){
    appLog('-----------New Api Call Start--------------');
    appLog('-------------REQUEST-----------------');
    appLog('<-Method->  ${response.requestOptions.method}');
    appLog('<-BaseUrl->  ${response.requestOptions.baseUrl}');
    appLog('<-Params->  ${response.requestOptions.queryParameters}');
    appLog('<-Path->  ${response.requestOptions.path}');
    appLog('<-Headers->  ${response.requestOptions.headers}');

    if(!kReleaseMode){
      log('<-Headers Full-> <-${response.requestOptions.path}-> ${response.requestOptions.headers}' );
    }
    appLog('<-Req Body->     ${response.requestOptions.data}');
    appLog('-------------RESPONSE----------------');
    if (!kReleaseMode) {
      log('<-Res Full Body-> <-${response.requestOptions.path}-> ${response.data.toString()}');
    }
    appLog('<-Res Body-> ${response.data.toString()}');
    appLog('-----------New Api Call End--------------');

    handler.next(response);
  }

  @override
  void onError(DioException err,ErrorInterceptorHandler handler){

    appLog('-----------New Api Error--------------');
    appLog('<-Method-> ${err.requestOptions.method}');
    appLog('<-BaseUrl-> ${err.requestOptions.baseUrl}');
    appLog('<-Params-> ${err.requestOptions.queryParameters}');
    appLog('<-Req Body-> ${err.requestOptions.data}');
    // appLog('<-Data-> Use Flipper to View Response');
    appLog('<-Path-> ${err.requestOptions.path}');
    appLog('<-Headers-> ${err.requestOptions.headers}');

    if (!kReleaseMode) {
      log('<-Headers Full-> <-${err.requestOptions.path}-> ${err.requestOptions.headers}' );
    }
    if (err.type == DioExceptionType.cancel) {
      return;
    }
    //here we check some auth regarding user
    handler.next(err);
  }

}