import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  bool isAgree =false;
  String email ='';
  Timer? _otpTimer;

  AuthBloc() : super(AuthInitial()) {
    on<PasswordHiddenEvent>(_isPasswordHidden);
    on<AuthLoginEvent>(_login);
    on<AuthOpenRegisterViewEvent>(_openRegisterView);
    on<AuthOpenLoginViewEvent>(_openLoginView);
    on<AuthRegisterEvent>(_registerUser);
    on<AuthPolicyEvent>(_isPolicy);
    on<AuthForgotPasswordEvent>(_forgotPasswordView);
    on<AuthEmailForgotPasswordEvent>(_emailForgotPasswordState);
    on<AuthIsOtpValidEvent>(_isOtpValid);
    on<AuthStartOtpTimerEvent>(_startOtpTimer);
    on<AuthTickOtpTimerEvent>(_tickOtpTimer);
  }

  void _isPasswordHidden(PasswordHiddenEvent event,Emitter<AuthState> emit){
    emit(PasswordHiddenState(isPassHidden: event.isPassHidden));
  }

  void _login(AuthLoginEvent event, Emitter<AuthState> emit) async{

    emit(AuthLoginState(isLoading: true ,isSuccess: false));
    await Future.delayed(Duration(seconds: 3));
    //call api here
    if(event.email =="demo@gmail.com" && event.password =="demo001"){
      emit(AuthLoginState(isLoading: false,isSuccess: true,));
    }else{
      emit(AuthLoginState(isLoading: false,isSuccess: false ));
    }
  }

  void _openRegisterView(AuthOpenRegisterViewEvent event, Emitter<AuthState> emit){
    emit(AuthOpenRegisterViewState());
  }
  void _openLoginView(AuthOpenLoginViewEvent event, Emitter<AuthState> emit){
    emit(AuthOpenLoginViewState());
  }

  void _registerUser(AuthRegisterEvent event ,Emitter<AuthState> emit) async{

    emit(AuthRegisterState(isLoading: true ,isSuccess: false, isAgree: isAgree));
    await Future.delayed(Duration(seconds: 3));
    //call api register user

    if(event.userName!='' && event.email!='' && event.password!='' && isAgree){

      emit(AuthRegisterState(isAgree: isAgree, isSuccess: true, isLoading: false));
      //here if api resp is like failed then
     // emit(AuthRegisterState(isAgree: isAgree, isSuccess: false, isLoading: false));
    }else if(!isAgree){
      emit(AuthRegisterState(isAgree: isAgree, isSuccess: false, isLoading: false));
    }
  }

  void _isPolicy(AuthPolicyEvent event , Emitter<AuthState> emit){
    isAgree=!isAgree;
    emit(AuthPolicyState(isAgree: isAgree));
  }

  void _forgotPasswordView(AuthForgotPasswordEvent event,Emitter<AuthState> emit){
    emit(AuthInitial());
    emit(AuthForgotPasswordState());
  }

  void _emailForgotPasswordState(AuthEmailForgotPasswordEvent event,Emitter<AuthState> emit)async{

    emit(AuthEmailForgotPasswordState(isLoading: true ,isSuccess: false));
    await Future.delayed(Duration(seconds: 3));
    //call api here
    if(event.email =="demo@gmail.com"){
      email=event.email;
      emit(AuthEmailForgotPasswordState(isLoading: false,isSuccess: true,));
    }else{
      emit(AuthEmailForgotPasswordState(isLoading: false,isSuccess: false ));
    }

  }

  void _isOtpValid(AuthIsOtpValidEvent event ,Emitter<AuthState> emit) async{
   String otp= event.otp;
   if(otp.length==4){
     emit(AuthIsOtpValidState(isLoading: true, isSuccess: false));
     await Future.delayed(Duration(seconds: 3));
     //check with api otp is valid or not
     emit(AuthIsOtpValidState(isLoading: false, isSuccess: true));
     //emit(AuthIsOtpValidState(isLoading: false, isSuccess: false));
   }else{
     emit(AuthIsOtpValidState(isLoading: false, isSuccess: false));
   }

  }

 void _startOtpTimer(AuthStartOtpTimerEvent event,Emitter<AuthState> emit){
    _otpTimer?.cancel();

    int totalSeconds=30;
    emit(AuthTickOtpTimerState(canResendOtp: false,otpSecondsRemaining: totalSeconds));
    _otpTimer=Timer.periodic(Duration(seconds: 1), (timer){
      int secondsLeft=totalSeconds-timer.tick;
      if(secondsLeft<=0){
        _otpTimer?.cancel();
        add(AuthTickOtpTimerEvent(0));
      }else{
        add(AuthTickOtpTimerEvent(secondsLeft));
      }
    });

 }

  void _tickOtpTimer(AuthTickOtpTimerEvent event, Emitter<AuthState> emit) {
    if (event.secondsLeft == 0) {
      emit(AuthTickOtpTimerState(otpSecondsRemaining: 0, canResendOtp: true));
    } else {
      emit(AuthTickOtpTimerState(otpSecondsRemaining: event.secondsLeft,canResendOtp: false));
    }
  }



    @override
  Future<void> close() {
      _otpTimer?.cancel();
    return super.close();
  }


}
