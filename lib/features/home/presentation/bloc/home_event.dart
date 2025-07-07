part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

final class HomeFetchAllProductEvent extends HomeEvent{
  @override
  List<Object?> get props => [];

}

final class HomeFetchAllCategoryEvent extends HomeEvent{
  @override
  List<Object?> get props => [];

}

final class HomeSelectAndUnselectCategoryEvent extends HomeEvent{
  final bool isSelect;
  final int index;

  const HomeSelectAndUnselectCategoryEvent({required this.isSelect,required this.index});

  @override
  List<Object?> get props => [ isSelect,index];

}



