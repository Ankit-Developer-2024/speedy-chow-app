

class ApiResponse<T>{

  final bool? success;
  final int? statusCode;
  final String? message;
  final T? data;

  ApiResponse({
    required this.message,
    required this.success,
    required this.statusCode,
    required this.data
});

  static fromJson<T>(Map<String,dynamic> json,{required Function? createResponseModel} ){
        return ApiResponse<T>(
        message: json["message"],
        success: json["success"],
        statusCode: json["rs"],
        data: json["data"]==null ? null : createResponseModel?.call(json["data"])
        );
  }

  static error(){
    return ApiResponse(message: "Something went wrong", success: false, statusCode: 0, data: null);

  }

  bool isSuccess(){
    return success ?? false;
  }

}