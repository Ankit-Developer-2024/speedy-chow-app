import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/home/data/data_source/local_source/product_local_source.dart';
import 'package:speedy_chow/features/home/data/models/product_model.dart';

class ProductLocalSourceImpl implements ProductLocalSource {
  @override
  Future<ApiResponse?> fetchAllProduct({required List<String> filterProductByName}) async {
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
    {
    "name": "Hakka Noodles #2",
    "description": "Stir-fried noodles with mixed vegetables, soy sauce, and garlic, offering a classic Indo-Chinese flavor.",
    "photo": "https://example.com/images/hakka_noodles.jpg",
    "price": 130,
    "discount": 5,
    "quantity": 11,
    "category": "Noodles",
    "rating": 3.1
    },
    {
    "name": "Strawberry Shake #3",
    "description": "Sweet and creamy milkshake blended with real strawberries, topped with whipped cream and strawberry syrup.",
    "photo": "https://example.com/images/strawberry_shake.jpg",
    "price": 90,
    "discount": 20,
    "quantity": 21,
    "category": "Shake",
    "rating": 4.9
    },
    {
    "name": "Strawberry Shake #4",
    "description": "Sweet and creamy milkshake blended with real strawberries, topped with whipped cream and strawberry syrup.",
    "photo": "https://example.com/images/strawberry_shake.jpg",
    "price": 90,
    "discount": 0,
    "quantity": 36,
    "category": "Shake",
    "rating": 4.6
    },
    {
    "name": "Chicken Burger #5",
    "description": "A juicy chicken patty grilled to perfection, served with mayonnaise, fresh veggies, and melted cheese inside a golden-brown bun.",
    "photo": "https://example.com/images/chicken_burger.jpg",
    "price": 150,
    "discount": 10,
    "quantity": 31,
    "category": "Burger",
    "rating": 3.8
    },
    {
    "name": "Veg Burger #6",
    "description": "A delicious veg burger made with a crispy vegetable patty, layered with fresh lettuce, tomatoes, onions, cheese, and a tangy mayo sauce inside a soft toasted bun.",
    "photo": "https://example.com/images/veg_burger.jpg",
    "price": 120,
    "discount": 15,
    "quantity": 41,
    "category": "Burger",
    "rating": 4.5
    },
    {
    "name": "Cold Coffee #7",
    "description": "Iced coffee blended with milk, sugar, and coffee powder, topped with froth and chocolate syrup.",
    "photo": "https://example.com/images/cold_coffee.jpg",
    "price": 70,
    "discount": 10,
    "quantity": 47,
    "category": "Beverage",
    "rating": 3.9
    },
    {
    "name": "Spring Rolls #8",
    "description": "Golden-fried rolls filled with a mix of finely chopped vegetables and Chinese spices, served with a tangy dipping sauce.",
    "photo": "https://example.com/images/spring_rolls.jpg",
    "price": 110,
    "discount": 10,
    "quantity": 41,
    "category": "Starter",
    "rating": 3.2
    },
    {
    "name": "Hakka Noodles #9",
    "description": "Stir-fried noodles with mixed vegetables, soy sauce, and garlic, offering a classic Indo-Chinese flavor.",
    "photo": "https://example.com/images/hakka_noodles.jpg",
    "price": 130,
    "discount": 15,
    "quantity": 41,
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
    {
    "name": "Veg Burger #16",
    "description": "A delicious veg burger made with a crispy vegetable patty, layered with fresh lettuce, tomatoes, onions, cheese, and a tangy mayo sauce inside a soft toasted bun.",
    "photo": "https://example.com/images/veg_burger.jpg",
    "price": 120,
    "discount": 0,
    "quantity": 18,
    "category": "Burger",
    "rating": 3.7
    },
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
