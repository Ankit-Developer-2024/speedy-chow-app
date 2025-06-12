part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {}

final class NavigationInitial extends NavigationState {
  @override
  List<Object?> get props => [];
}

final class NavigationSelectViewState  extends NavigationState{
  final int currentIndex;
  final String currentRoute;

  NavigationSelectViewState({required this.currentIndex,required this.currentRoute});

  @override
  List<Object?> get props => [currentIndex,currentRoute];
}