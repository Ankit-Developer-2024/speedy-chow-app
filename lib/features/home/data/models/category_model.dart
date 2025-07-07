import 'package:speedy_chow/features/home/domain/enitites/category.dart';

class CategoryModel extends Category {
  CategoryModel(
      {required super.id,
      required super.name,
      required super.imgUrl,
      required super.isSelected});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'] ?? '',
        name: json["name"] ?? '',
        imgUrl: json["imgUrl"] ?? '',
        isSelected: false);
  }

  static List<CategoryModel> createResponseModel(
      List<Map<String, dynamic>> category) {
    List<CategoryModel> categoryModel =
        category.map((item) => CategoryModel.fromJson(item)).toList();

    return categoryModel;
  }
}
