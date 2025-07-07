

import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/cart/data/data_source/local_source/cart_local_source.dart';
import 'package:speedy_chow/features/cart/data/data_source/local_source/cart_local_source_impl.dart';
import 'package:speedy_chow/features/cart/data/repositories/user_cart_repository_impl.dart';
import 'package:speedy_chow/features/cart/domain/repositories/user_cart_repository.dart';
import 'package:speedy_chow/features/cart/domain/use_case/fetch_user_cart.dart';
import 'package:speedy_chow/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:speedy_chow/features/config/bloc/config_bloc.dart';
import 'package:speedy_chow/features/config/data/repository/config_repo_impl.dart';
import 'package:speedy_chow/features/home/data/data_source/local_source/category_local_source.dart';
import 'package:speedy_chow/features/home/data/data_source/local_source/category_local_source_impl.dart';
import 'package:speedy_chow/features/home/data/data_source/local_source/product_local_source.dart';
import 'package:speedy_chow/features/home/data/data_source/local_source/product_local_source_impl.dart';
import 'package:speedy_chow/features/home/data/repositories/category_repository_impl.dart';
import 'package:speedy_chow/features/home/data/repositories/product_repository_impl.dart';
import 'package:speedy_chow/features/home/domain/repositories/category_repository.dart';
import 'package:speedy_chow/features/home/domain/repositories/product_repository.dart';
import 'package:speedy_chow/features/home/domain/use_cases/fetch_all_category.dart';
import 'package:speedy_chow/features/home/domain/use_cases/fetch_all_products.dart';
import 'package:speedy_chow/features/home/presentation/bloc/home_bloc.dart';
import 'package:speedy_chow/features/product_details/data/data_source/local_source/product_detail_local_source.dart';
import 'package:speedy_chow/features/product_details/data/data_source/local_source/product_detail_local_source_impl.dart';
import 'package:speedy_chow/features/product_details/data/repositories/product_detail_repository_impl.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/product_detail_repository.dart';
import 'package:speedy_chow/features/product_details/domain/use_case/product_detail_fetch_product_use_case.dart';
import 'package:speedy_chow/features/product_details/presentation/bloc/product_detail_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async{


  //getIt.registerSingleton(navigatorKey);

  final FlutterLocalization localization = FlutterLocalization.instance;

  //localization
  getIt.registerSingleton(localization);


  //config controller 
   _initConfig();

  //_initNavigation
  _initNavigationBloc();

  //auth bloc
   _initAuthBloc();

   //home bloc
   _initHomeBloc();

   //product detail bloc
   _initProductDetailBloc();

    //cart
   _initCartBloc();

  // profileBloc
   _initProfileBloc();


}

void _initConfig(){
    getIt.registerLazySingleton<ConfigBloc>(()=>ConfigBloc(configRepoImpl: ConfigRepoImpl()));
}

void _initNavigationBloc(){
    getIt.registerLazySingleton<NavigationBloc>(()=>NavigationBloc());
}

void _initAuthBloc(){
  getIt.registerFactory<AuthBloc>(()=>AuthBloc());
}

void _initHomeBloc(){
  //data_source
  getIt..registerFactory<ProductLocalSource>(()=>ProductLocalSourceImpl())
  ..registerFactory<CategoryLocalSource>(()=>CategoryLocalSourceImpl())
  //repositories
  ..registerFactory<ProductRepository>(()=>ProductRepositoryImpl(productLocalSource: getIt<ProductLocalSource>()))
  ..registerFactory<CategoryRepository>(()=>CategoryRepositoryImpl(categoryLocalSource: getIt<CategoryLocalSource>()))
  //use_case
  ..registerFactory<FetchAllProduct>(()=>FetchAllProduct(productRepository: getIt<ProductRepository>()))
  ..registerFactory<FetchAllCategory>(()=>FetchAllCategory(categoryRepository: getIt<CategoryRepository>()))
  //bloc
  ..registerFactory<HomeBloc>(()=>HomeBloc(fetchAllProduct: getIt<FetchAllProduct>(),fetchAllCategory: getIt<FetchAllCategory>()));

}

void _initProductDetailBloc(){
  //data_source
  getIt..registerFactory<ProductDetailLocalSource>(()=>ProductDetailLocalSourceImpl())
  //repositories
  ..registerFactory<ProductDetailRepository>(()=>ProductDetailRepositoryImpl(productDetailLocalSource: getIt<ProductDetailLocalSource>()))
  //use_case
  ..registerFactory<ProductDetailFetchProductUseCase>(()=>ProductDetailFetchProductUseCase(productDetailRepository: getIt<ProductDetailRepository>()))
  //bloc
  ..registerFactory<ProductDetailBloc>(()=>ProductDetailBloc(productDetailFetchProductUseCase: getIt<ProductDetailFetchProductUseCase>()));
}

void _initCartBloc(){
  //data_source
  getIt..registerFactory<CartLocalSource>(()=>CartLocalSourceImpl())
  //repositories
  ..registerFactory<UserCartRepository>(()=>UserCartRepositoryImpl(cartLocalSource: getIt<CartLocalSource>()))
  //use_case
  ..registerFactory<FetchUserCart>(()=>FetchUserCart(userCartRepository: getIt<UserCartRepository>()))
  //bloc
  ..registerFactory<CartBloc>(()=>CartBloc(fetchUserCart: getIt<FetchUserCart>()));
}

void _initProfileBloc(){
  getIt.registerFactory<ProfileBloc>(()=>ProfileBloc());
}

void initFlutterLocalization() {
    getIt<FlutterLocalization>().init(
        mapLocales: [
          MapLocale('en',
              AppLocal.EN,
              countryCode: 'IN',

          )
        ],
        initLanguageCode: 'en');

}
