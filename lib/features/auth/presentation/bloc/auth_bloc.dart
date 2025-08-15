import 'dart:async';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/auth/data/models/auth_models.dart';
import 'package:speedy_chow/features/auth/data/models/user_model.dart';
import 'package:speedy_chow/features/auth/domain/enitites/user.dart';
import 'package:speedy_chow/features/auth/domain/use_cases/auth_login_use_case.dart';
import 'package:speedy_chow/features/auth/domain/use_cases/fetch_user_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  bool isAgree =false;
  String email ='';
  Timer? _otpTimer;
  UserModel? userModel;
  final AuthLoginUseCase authLoginUseCase;
  final FetchUserUseCase fetchUserUseCase;

  AuthBloc({required this.authLoginUseCase,required this.fetchUserUseCase}) : super(AuthInitial()) {
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
    on<AuthResetPasswordEvent>(_resetPassword);
    on<AuthUserEvent>(_fetchUser);
  }

  void _isPasswordHidden(PasswordHiddenEvent event,Emitter<AuthState> emit){
    emit(PasswordHiddenState(isPassHidden: event.isPassHidden));
  }

  void _login(AuthLoginEvent event, Emitter<AuthState> emit) async{

    try{

      emit(AuthLoginState(isLoading: true ,isSuccess: false,message: "",data: AuthModels(id: "", email: "", role: "")));
      await Future.delayed(Duration(seconds: 1));

      ApiResponse? response=await authLoginUseCase(AuthLoginParam(email: event.email, password: event.password));
      if(response?.success==true){
        emit(AuthLoginState(isLoading: false, isSuccess: true, message: response!.message.toString(), data: response.data ?? AuthModels(id: "", email: "", role: "")));
      }else{
        emit(AuthLoginState(isLoading: false, isSuccess: false, message: response!.message.toString(), data: response.data ?? AuthModels(id: "", email: "", role: "")));
      }
    }catch(err){
      emit(AuthLoginState(isLoading: false, isSuccess: false, message: err.toString(), data: AuthModels(id: "", email: "", role: "")));
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


  void _resetPassword(AuthResetPasswordEvent event ,Emitter<AuthState> emit) async{

    if(event.newPassword == event.newConfirmPassword){
      emit(AuthResetPasswordMatchState(isMatch: true));
      emit(AuthResetPasswordState(isLoading: true, isSuccess: false));
      //create new password api
      //no error api
      emit(AuthResetPasswordState(isLoading: false, isSuccess: true));
      //error api
    //  emit(AuthResetPasswordState(isLoading: false, isSuccess: false));
    }else{
      emit(AuthResetPasswordMatchState(isMatch: false));
    }

  }

  void _fetchUser(AuthUserEvent event,Emitter<AuthState> emit)async{
      emit(AuthUserState(isLoading: true,isSuccess: false,message: ""));
      try{
        ApiResponse? response= await fetchUserUseCase(NoParams());
        if(response?.success==true){
          userModel=response?.data;
          emit(AuthUserState(isLoading: false, isSuccess: true, message: response!.message.toString()));
        }else{
          emit(AuthUserState(isLoading: false, isSuccess: false, message: response!.message.toString()));
        }
      }catch(e){
        emit(AuthUserState(isLoading: false, isSuccess: false, message: e.toString()));
      }

  }

  void _updateUser(AuthUpdateUserEvent event , Emitter<AuthState> emit){
    userModel=event.user;
    emit(AuthUpdateUserState());
  }





    @override
  Future<void> close() {
      _otpTimer?.cancel();
    return super.close();
  }


}
