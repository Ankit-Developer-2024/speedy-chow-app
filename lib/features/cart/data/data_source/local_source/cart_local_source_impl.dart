import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/cart/data/data_source/local_source/cart_local_source.dart';
import 'package:speedy_chow/features/cart/data/models/cart_model.dart';

class CartLocalSourceImpl implements CartLocalSource{
  @override
  Future<ApiResponse?> fetchUserCart(String userId) async{
     await Future.delayed(Duration(seconds: 2));


     var items = [
       {
         "name": "Hakka Noodles #9",
         "description": "Stir-fried noodles with mixed vegetables, soy sauce, and garlic, offering a classic Indo-Chinese flavor.",
         "photo": "https://example.com/images/hakka_noodles.jpg",
         "price": 130,
         "discount": 15,
         "quantity": 0,
         "category": "Noodles",
         "rating": 4.2
       },
       {
         "name": "Strawberry Shake #10",
         "description": "Sweet and creamy milkshake blended with real strawberries, topped with whipped cream and strawberry syrup.",
         "photo": "https://example.com/images/strawberry_shake.jpg",
         "price": 90,
         "discount": 20,
         "quantity": 13,
         "category": "Shake",
         "rating": 4.9
       },
       {
         "name": "Chicken Burger #11",
         "description": "A juicy chicken patty grilled to perfection, served with mayonnaise, fresh veggies, and melted cheese inside a golden-brown bun.",
         "photo": "https://example.com/images/chicken_burger.jpg",
         "price": 150,
         "discount": 10,
         "quantity": 29,
         "category": "Burger",
         "rating": 3.3
       },
       {
         "name": "Hakka Noodles #13",
         "description": "Stir-fried noodles with mixed vegetables, soy sauce, and garlic, offering a classic Indo-Chinese flavor.",
         "photo": "https://example.com/images/hakka_noodles.jpg",
         "price": 130,
         "discount": 0,
         "quantity": 26,
         "category": "Noodles",
         "rating": 4.8
       },
       {
         "name": "Strawberry Shake #14",
         "description": "Sweet and creamy milkshake blended with real strawberries, topped with whipped cream and strawberry syrup.",
         "photo": "https://example.com/images/strawberry_shake.jpg",
         "price": 90,
         "discount": 10,
         "quantity": 13,
         "category": "Shake",
         "rating": 4.4
       },
       {
         "name": "Spring Rolls #15",
         "description": "Golden-fried rolls filled with a mix of finely chopped vegetables and Chinese spices, served with a tangy dipping sauce.",
         "photo": "https://example.com/images/spring_rolls.jpg",
         "price": 110,
         "discount": 20,
         "quantity": 44,
         "category": "Starter",
         "rating": 4.2
       },
     ];
     double totalPrice=items.fold(0,(prev,curr){
       num newPrice=curr["quantity"]==0 ? 0 : discountPrice(curr["price"] as int, curr["discount"] as int);
       return prev+newPrice;
     });

     Map<String ,dynamic> json={
       "message": "Cart fetch Successfully",
       "success": true,
       "rs": 200,
       "data": {
         "totalPrice":totalPrice,
         "cartItem":items
       },
     };

     return ApiResponse.fromJson(json, createResponseModel: CartModel.createResponseModel);

  }

}