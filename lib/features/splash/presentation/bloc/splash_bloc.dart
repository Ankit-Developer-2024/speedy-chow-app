
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/config/bloc/config_bloc.dart';
import 'package:speedy_chow/features/splash/domain/use_cases/verfiy_token_use_case.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  final ConfigBloc configBloc;
  final VerifyTokenUseCase verifyTokenUseCase;

  int _introPart=0;

  SplashBloc({required this.configBloc,required this.verifyTokenUseCase}) : super(SplashInitial()) {
    on<SplashViewCompleteEvent>(_splashViewComplete);
    on<SplashOneTimeUiEvent>(_changeOneTimeUi);
    on<SplashOneTimeUiSkipEvent>(_oneTimeUiSkip);
  }

  void _splashViewComplete(SplashViewCompleteEvent event ,Emitter<SplashState> emit)async{
     await  Future.delayed(Duration(seconds: 2),);
     if(configBloc.state.isAppInstall==true){
       ApiResponse? response=await verifyTokenUseCase(NoParams());
       if(response?.success==true){
        emit(ShowLoginViewState(screenName: AppRoutes.home));
       }else{
         emit(ShowLoginViewState(screenName: AppRoutes.login));
       }
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
