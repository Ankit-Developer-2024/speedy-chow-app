part of 'navigation_bloc.dart';


sealed class NavigationEvent extends Equatable {}

final class NavigationTabChangedEvent   extends NavigationEvent{
  final int index;

   NavigationTabChangedEvent({required this.index});

  @override
  List<Object?> get props => [index];


}
