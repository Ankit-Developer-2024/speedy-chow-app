import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/home/data/data_source/local_source/product_local_source.dart';
import 'package:speedy_chow/features/home/data/models/product_model.dart';

class ProductLocalSourceImpl implements ProductLocalSource {
  @override
  Future<ApiResponse?> fetchAllProduct({required List<String> filterProductByName}) async {
    await Future.delayed(Duration(seconds: 2));

    var data = [
    {
      "name": "",
    "description": "Rich and creamy pasta made with succulent cubes of paneer, tossed in a flavorful white sauce with herbs and saut\u00e9ed vegetables.",
    "image": "https://example.com/images/paneer_pasta.jpg",
    "price": 180,
    "discountPercentage": 10,
    "discountedPrice": 10,
    "totalQuantity": 50,
    "category": "Pasta",
    "rating": 3.1
  },
    {
    "name": "Hakka Noodles Paneer Pasta #1#2",
    "description": "Stir-fried noodles with mixed vegetables, soy sauce, and garlic, offering a classic Indo-Chinese flavor.",
    "image": "https://example.com/images/hakka_noodles.jpg",
    "price": 130,
    "discountPercentage": 5,
    "discountedPrice": 5,
    "totalQuantity": 11,
    "category": "Noodles",
    "rating": 3.1
    }
    ];
    if(filterProductByName.isNotEmpty){
      data=data.where((item)=>filterProductByName.contains(item['category'])).toList();
    }

    Map<String, dynamic> json = {
      "message": "Product fetch Successfully",
      "success": true,
      "rs": 200,
      "data": data,
    };
    ApiResponse response = await ApiResponse.fromJson(json,
        createResponseModel: ProductModel.createResponseModel);
    return response;
  }
}
