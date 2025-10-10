part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeFetchAllProductState extends HomeState{
  final String msg;
  final bool loading;
  final bool success;
  final List<Product> data ;

  const HomeFetchAllProductState({required this.msg,required this.loading,required this.success,required this.data});


  @override
  List<Object> get props => [msg,loading,success,data];
}

final class HomeFetchAllCategoryState extends HomeState{
  final String msg;
  final bool loading;
  final bool success;
  final List<Category> data ;

  const HomeFetchAllCategoryState({required this.msg,required this.loading,required this.success,required this.data});


  @override
  List<Object> get props => [msg,loading,success,data];

}

final class HomeSelectAndUnselectCategoryState extends HomeState{
   final DateTime dateTime=DateTime.now();

  @override
  List<Object?> get props => [ dateTime];

}

final class HomeSearchProductByNameState extends HomeState{
  final bool loading;
  final bool success;
  final String msg;
  final List<SearchProduct> searchProduct;

  const HomeSearchProductByNameState({required this.loading,required this.success,required this.msg,required this.searchProduct});
  @override
  List<Object?> get props => [loading,success,msg,searchProduct];

}