import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  bool isAgree =false;

  AuthBloc() : super(AuthInitial()) {
    on<PasswordHiddenEvent>(_isPasswordHidden);
    on<AuthLoginEvent>(_login);
    on<AuthOpenRegisterViewEvent>(_openRegisterView);
    on<AuthOpenLoginViewEvent>(_openLoginView);
    on<AuthRegisterEvent>(_registerUser);
    on<AuthPolicyEvent>(_isPolicy);
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

     print("0000000000000000$isAgree");
    emit(AuthRegisterState(isLoading: true ,isSuccess: false, isAgree: isAgree));
    await Future.delayed(Duration(seconds: 3));
    //call api register user

    if(event.userName!='' && event.email!='' && event.password!='' && isAgree){

      emit(AuthRegisterState(isAgree: isAgree, isSuccess: true, isLoading: false));
      print("---------------------=$isAgree");
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

}
