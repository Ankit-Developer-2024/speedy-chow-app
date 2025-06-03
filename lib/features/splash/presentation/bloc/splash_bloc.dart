
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/features/config/bloc/config_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  final ConfigBloc configBloc;

  int _introPart=0;

  SplashBloc({required this.configBloc}) : super(SplashInitial()) {
    on<SplashViewCompleteEvent>(_splashViewComplete);
    on<SplashOneTimeUiEvent>(_changeOneTimeUi);
    on<SplashOneTimeUiSkipEvent>(_oneTimeUiSkip);
  }

  void _splashViewComplete(SplashViewCompleteEvent event ,Emitter<SplashState> emit)async{
     await  Future.delayed(Duration(seconds: 5),);
     if(configBloc.state.isAppInstall==true){
       //check user is login ? show home screen : login screen
       emit(ShowLoginViewState());
     }else{
       emit(ShowOneTimeUiState());
     }

  }

  void _changeOneTimeUi(SplashOneTimeUiEvent event,Emitter<SplashState> emit){
    if(_introPart+1>2){
       emit(SplashOneTimeUiCompleteState());
    }else{
      _introPart++;
      emit(SplashOneTimeUiState(introPart: _introPart));
    }
  }

  void _oneTimeUiSkip(SplashOneTimeUiSkipEvent event,Emitter<SplashState> emit){
    emit(SplashOneTimeUiCompleteState());
  }
}
