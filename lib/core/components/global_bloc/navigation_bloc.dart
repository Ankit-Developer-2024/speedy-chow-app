import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<NavigationTabChangedEvent>(_selectCurrentTab);
  }

  void _selectCurrentTab(NavigationTabChangedEvent event,Emitter<NavigationState> emit){
     final currentRoute = _mapIndexToRoute(event.index);

     emit(NavigationSelectViewState(currentIndex: event.index,currentRoute: currentRoute));

  }

}


String _mapIndexToRoute(int index){
  switch(index){
    case 0 :
      return AppRoutes.home;
    case 1:
      return AppRoutes.cart;
    case 2:
      return AppRoutes.order;
    case 3:
      return AppRoutes.profile;
    default:
      return AppRoutes.home;
  }
}
