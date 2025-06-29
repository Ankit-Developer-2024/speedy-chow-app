import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/product_details/data/data_source/local_source/product_detail_local_source.dart';
import 'package:speedy_chow/features/product_details/data/models/product_detail_model.dart';

class ProductDetailLocalSourceImpl implements ProductDetailLocalSource{
  @override
  Future<ApiResponse?> fetchProduct(String productId) async{
    await Future.delayed(Duration(seconds: 2));

    var data = [
      {
        "name": "Paneer Pasta #1",
        "description": "Rich and creamy pasta made with succulent cubes of paneer, tossed in a flavorful white sauce with herbs and saut\u00e9ed vegetables.",
        "photo": "https://example.com/images/paneer_pasta.jpg",
        "price": 180,
        "discount": 10,
        "quantity": 50,
        "category": "Pasta",
        "rating": 3.1
      },
    ];
    Map<String, dynamic> json = {
      "message": "Product fetch Successfully",
      "success": true,
      "rs": 200,
      "data": data,
    };
    ApiResponse response = await ApiResponse.fromJson(json,
        createResponseModel: ProductDetailModel.createResponseModel);
    return response;
  }

}