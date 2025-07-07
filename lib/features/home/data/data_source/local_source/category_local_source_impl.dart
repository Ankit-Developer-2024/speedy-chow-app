import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/home/data/data_source/local_source/category_local_source.dart';
import 'package:speedy_chow/features/home/data/models/category_model.dart';

class CategoryLocalSourceImpl implements CategoryLocalSource{
  @override
  Future<ApiResponse?> fetchAllCategory() async{
    Future.delayed(Duration(seconds: 2));

    var data=[
      {
        "name": "Burger",
        "image": "https://example.com/images/burger_category.jpg"
      },
      {
        "name": "Pasta",
        "image": "https://example.com/images/pasta_category.jpg"
      },
      {
        "name": "Pastry",
        "image": "https://example.com/images/pastry_category.jpg"
      },
      {
        "name": "Juice",
        "image": "https://example.com/images/juice_category.jpg"
      },
      {
        "name": "Shake",
        "image": "https://example.com/images/shake_category.jpg"
      },
      {
        "name": "Starter",
        "image": "https://example.com/images/starter_category.jpg"
      },
      {
        "name": "Noodles",
        "image": "https://example.com/images/noodles_category.jpg"
      },
      {
        "name": "Beverage",
        "image": "https://example.com/images/beverage_category.jpg"
      }
    ];
    Map<String,dynamic> json={
      "message": "Category fetch Successfully",
      "success": true,
      "rs": 200,
      "data": data,
    };

    return ApiResponse.fromJson(json, createResponseModel: CategoryModel.createResponseModel);
  }
}