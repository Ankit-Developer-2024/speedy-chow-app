import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/connectivity/connectivity.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/home/domain/entities/category.dart';
import 'package:speedy_chow/features/home/domain/entities/product.dart';
import 'package:speedy_chow/features/home/domain/entities/search_product.dart';
import 'package:speedy_chow/features/home/domain/use_cases/fetch_all_category.dart';
import 'package:speedy_chow/features/home/domain/use_cases/fetch_all_products.dart';
import 'package:speedy_chow/features/home/domain/use_cases/search_product_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchAllProduct fetchAllProduct;
  final FetchAllCategory fetchAllCategory;
  final SearchProductUseCase searchProductUseCase;

  List<Category> selectedCategory=<Category>[];
  List<String> selectedCategoryName=[];
  List<Product> product=<Product>[];
  List<Product> filterProduct=<Product>[];

  HomeBloc({
    required this.fetchAllProduct,
    required this.fetchAllCategory,
    required this.searchProductUseCase,
  })
      : super(HomeInitial()) {
    on<HomeFetchAllProductEvent>(_fetchAllProduct);
    on<HomeFetchAllCategoryEvent>(_fetchAllCategory);
    on<HomeSelectAndUnselectCategoryEvent>(_selectAndUnselectCategory);
    on<HomeSearchProductByNameEvent>(_searchProduct);
  }

  void _fetchAllProduct(
      HomeFetchAllProductEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeFetchAllProductState(
          msg: "loading", loading: true, success: false, data: []));
      if(await CheckConnectivity.checkConnectivity()) {
      ApiResponse? response = await fetchAllProduct(ProductParams(productName: selectedCategoryName));
      if (response?.success == true) {
        product=response?.data ?? [];
        emit(HomeFetchAllProductState(
            success: response?.success ?? false,
            loading: false,
            data: response?.data ?? [],
            msg: response?.message ?? ''));
      } else {
        emit(HomeFetchAllProductState(
            success: false,
            loading: false,
            data: response?.data ?? [],
            msg: response?.message ?? 'Something went wrong'));
      }}else{
        emit(HomeFetchAllProductState(
            msg: "No internet!", loading: false, success: false, data: []));
      }
    } catch (e) {
      emit(HomeFetchAllProductState(
          success: false, loading: false, data: [], msg: e.toString()));
    }
  }

  void _fetchAllCategory(HomeFetchAllCategoryEvent event, Emitter<HomeState> emit) async {
    if(await CheckConnectivity.checkConnectivity()) {
      try {
        emit(HomeFetchAllCategoryState(
            msg: "", loading: true, success: false, data: []));

        ApiResponse? response = await fetchAllCategory(NoParams());
        if (response?.success == true) {
          selectedCategory = response?.data ?? [];
          emit(HomeSelectAndUnselectCategoryState());
          // emit(HomeFetchAllProductState(
          //     msg: response?.message ?? "",
          //     loading: false,
          //     success: true,
          //     data: response?.data ?? []));
        } else {
          emit(HomeFetchAllProductState(
              msg: response?.message ?? 'Something went wrong',
              loading: false,
              success: true,
              data: response?.data ?? []));
        }
      } catch (e) {
        emit(HomeFetchAllProductState(
            msg: e.toString(), loading: false, success: true, data: []));
      }
    }
  }

  void _selectAndUnselectCategory(HomeSelectAndUnselectCategoryEvent event,Emitter<HomeState> emit){

     for (int i=0 ;i<selectedCategory.length ; i++) {
         if(event.index==i){
           selectedCategory[i].isSelected=event.isSelect;
         }
         
    }
     for(var item in selectedCategory){
       if(item.isSelected==true && item.name!=null){
           selectedCategoryName.contains(item.name!) ? null:  selectedCategoryName.add(item.name!);
       }else{
         selectedCategoryName.remove(item.name!);
       }
     }
     add(HomeFetchAllProductEvent());
     emit(HomeSelectAndUnselectCategoryState());

  }

  void _searchProduct(HomeSearchProductByNameEvent event,Emitter<HomeState> emit)async{
    try{
      emit(HomeSearchProductByNameState(loading: true, success: false, msg: "", searchProduct: []));
      if(await CheckConnectivity.checkConnectivity()) {
      ApiResponse? response = await searchProductUseCase(SearchProductUseCaseParam(name: event.name));
      if(response?.success==true){
        emit(HomeSearchProductByNameState(loading: false, success: true, msg: response?.message ?? "Product Searched!", searchProduct: response?.data));
      }else{
        emit(HomeSearchProductByNameState(loading: false, success: false, msg: response?.message ?? "No product found!", searchProduct: []));
      }}else{
        emit(HomeSearchProductByNameState(loading: false, success: false, msg: "No internet!", searchProduct: []));
      }
    }catch(err){
      emit(HomeSearchProductByNameState(loading: false, success: false, msg: err.toString(), searchProduct: []));

    }
  }



}
