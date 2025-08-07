

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_manager.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class DioRequest{

  static Future<ApiResponse?> get<T>(String url,{
        Map<String,dynamic>queryParam= const {},
        bool retryApiCall= false,
        required Function createResponseModel,
        CancelToken? cancelToken
     }) async{
      try{
             Response response = await DioManager.httpDio.get(url,queryParameters:queryParam,cancelToken: cancelToken);
                       if(response.data != null){
                          return ApiResponse.fromJson<T>(response.data, createResponseModel: createResponseModel);
                       }
                       return null;
      } on DioException catch (err) {
            if(err.response != null && (err.response?.statusCode ?? 0) > 299 || (err.response?.statusCode ?? 0)<200){
              if(err.response?.data != null && err.response?.data is Map){
                return ApiResponse.fromJson<T>(err.response?.data, createResponseModel: createResponseModel);
              }
              return null;
            }else{
              if (retryApiCall) {
                return await get<T>(url,
                    queryParam: queryParam,
                    createResponseModel: createResponseModel,
                    cancelToken: cancelToken);
              } else {
                return null;
              }
            }
      }catch(e){
        appLog(e.toString());
        if (retryApiCall) {
          return await get<T>(url,
              queryParam: queryParam,
              createResponseModel: createResponseModel,
              cancelToken: cancelToken);
        } else {
          return null;
        }
      }
  }


  static Future<ApiResponse?> post<T>(String url,{
    Map<String,dynamic>queryParam= const {},
    Map<String, dynamic>? data,
    bool retryApiCall= false,
    required Function createResponseModel,
    CancelToken? cancelToken
  }) async{

     try{
       Response response = await DioManager.httpDio.post(url,data: jsonEncode(data),queryParameters: queryParam,cancelToken: cancelToken);
       if(response.data != null){
         return ApiResponse.fromJson(response.data, createResponseModel: createResponseModel);
       }
       return null;
     } on DioException catch (err){
       if(err.response != null && (err.response?.statusCode ?? 0) > 299 || (err.response?.statusCode ?? 0)<200){
         if(err.response?.data != null && err.response?.data is Map){
           return ApiResponse.fromJson<T>(err.response?.data, createResponseModel: createResponseModel);
         }
         return null;
       }else{
         if (retryApiCall) {
           return await post<T>(url,
               queryParam: queryParam,
               data: data,
               createResponseModel: createResponseModel,
               cancelToken: cancelToken);
         } else {
           return null;
         }
       }
     } catch (e){
       appLog(e.toString());
       if (retryApiCall) {
         return await post<T>(url,
             queryParam: queryParam,
             data: data,
             createResponseModel: createResponseModel,
             cancelToken: cancelToken);
       } else {
         return null;
       }
     }

  }



  static Future<ApiResponse?> put<T>(String url,{
    Map<String,dynamic>queryParam= const {},
    Map<String, dynamic>? data,
    bool retryApiCall= false,
    required Function createResponseModel,
    CancelToken? cancelToken
  })async{
    try{
      Response response = await DioManager.httpDio.put(url,data: jsonEncode(data),queryParameters: queryParam,cancelToken: cancelToken);
      if(response.data != null){
        return ApiResponse.fromJson(response.data, createResponseModel: createResponseModel);
      }
      return null;
    } on DioException catch (err){
      if(err.response != null && (err.response?.statusCode ?? 0) > 299 || (err.response?.statusCode ?? 0)<200){
        if(err.response?.data != null && err.response?.data is Map){
          return ApiResponse.fromJson<T>(err.response?.data, createResponseModel: createResponseModel);
        }
        return null;
      }else{
        if (retryApiCall) {
          return await put<T>(url,
              queryParam: queryParam,
              data: data,
              createResponseModel: createResponseModel,
              cancelToken: cancelToken);
        } else {
          return null;
        }
      }
    } catch (e){
      appLog(e.toString());
      if (retryApiCall) {
        return await put<T>(url,
            queryParam: queryParam,
            data: data,
            createResponseModel: createResponseModel,
            cancelToken: cancelToken);
      } else {
        return null;
      }
    }
  }

  static Future<ApiResponse?> patch<T>(String url,{
    Map<String,dynamic>queryParam= const {},
    Map<String, dynamic>? data,
    bool retryApiCall= false,
    required Function createResponseModel,
    CancelToken? cancelToken
  })async{
    try{
      Response response = await DioManager.httpDio.patch(url,data: jsonEncode(data),queryParameters: queryParam,cancelToken: cancelToken);
      if(response.data != null){
        return ApiResponse.fromJson(response.data, createResponseModel: createResponseModel);
      }
      return null;
    } on DioException catch (err){
      if(err.response != null && (err.response?.statusCode ?? 0) > 299 || (err.response?.statusCode ?? 0)<200){
        if(err.response?.data != null && err.response?.data is Map){
          return ApiResponse.fromJson<T>(err.response?.data, createResponseModel: createResponseModel);
        }
        return null;
      }else{
        if (retryApiCall) {
          return await patch<T>(url,
              queryParam: queryParam,
              data: data,
              createResponseModel: createResponseModel,
              cancelToken: cancelToken);
        } else {
          return null;
        }
      }
    } catch (e){
      appLog(e.toString());
      if (retryApiCall) {
        return await patch<T>(url,
            queryParam: queryParam,
            data: data,
            createResponseModel: createResponseModel,
            cancelToken: cancelToken);
      } else {
        return null;
      }
    }
  }

}