

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/core/services/networking/interceptor/curl_interceptor.dart';
import 'package:speedy_chow/core/services/networking/interceptor/logging_interceptor.dart';
import 'package:speedy_chow/core/services/networking/interceptor/token_interceptor.dart';
import 'package:speedy_chow/core/util/config/app_secret_config.dart';

class DioManager{

  static const int _maxLineWidth=90;
  static final BaseOptions _options=BaseOptions(
    baseUrl: AppSecretConfig.instance!.values!.baseUrl,
    connectTimeout: AppSecretConfig.instance!.values!.timeOut,
    receiveTimeout: AppSecretConfig.instance!.values!.timeOut,
    sendTimeout: AppSecretConfig.instance!.values!.timeOut
  );

  static final _prettyDioLogger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: true,
    error: true,
    compact: true,
    maxWidth: _maxLineWidth
  );

  static final _curlInterceptor = CurlInterceptor();
  static final _loggingInterceptor = LoggingInterceptor();
  static final _tokenInterceptor = TokenInterceptor();

  static Dio? _instance;
  static Dio get httpDio{
    if(_instance==null){
      _instance=Dio(_options);
      _instance!.interceptors.add(_loggingInterceptor);
      _instance!.interceptors.add(_tokenInterceptor);
      if(AppSecretConfig.instance!.flavor !=Flavor.production){
         _instance!.interceptors.add(_prettyDioLogger);
         _instance!.interceptors.add(_curlInterceptor);
      }
      return _instance!;
    }else{
      _instance!.interceptors.clear();
      _instance!.interceptors.add(_loggingInterceptor);
      _instance!.interceptors.add(_tokenInterceptor);
      if(AppSecretConfig.instance!.flavor != Flavor.production){
        _instance!.interceptors.add(_prettyDioLogger);
        _instance!.interceptors.add(_curlInterceptor);
      }
      return _instance!;
    }
  }

}