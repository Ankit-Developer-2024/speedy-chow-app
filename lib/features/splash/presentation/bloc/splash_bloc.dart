
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  int _introPart=0;

  SplashBloc() : super(SplashInitial()) {
    on<SplashViewCompleteEvent>(_splashViewComplete);
    on<SplashOneTimeUiEvent>(_changeOneTimeUi);
  }

  void _splashViewComplete(SplashViewCompleteEvent event ,Emitter<SplashState> emit)async{
     await  Future.delayed(Duration(seconds: 5),);

     emit(SplashViewCompleteState());
  }

  void _changeOneTimeUi(SplashOneTimeUiEvent event,Emitter<SplashState> emit){
    if(_introPart+1>2){
       emit(SplashOneTimeUiCompleteState());
    }else{
      _introPart++;
      emit(SplashOneTimeUiState(introPart: _introPart));
    }

  }
}
