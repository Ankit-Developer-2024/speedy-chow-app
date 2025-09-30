import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/preferences/app_secure_storage.dart';
import 'package:speedy_chow/core/components/models/user_model.dart';
import 'package:speedy_chow/features/profile/domain/use_cases/update_user_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

   Map<String,dynamic> accountDeletionReason= {
     'I don’t find it useful anymore': false,
     'I’m concerned about my privacy': false,
     'I found a better alternative': false,
     'I receive too many emails/notifications': false,
     'I had a bad experience': false,
     'I don’t use it often': false,
     'I created a duplicate account': false,
     'App/service is too slow or buggy': false,
     'I want to take a break': false,
     'Other': false,
   };

   UserModel? userModel;

  String? selectedAccountDeletionReason;
  final UpdateUserUseCase updateUserUseCase;

  ProfileBloc({required this.updateUserUseCase}) : super(ProfileInitial()) {
    on<PersonalDataUpdateProfileEvent>(_personalDataUpdate);
    on<ProfileAccountDeletionCheckBoxEvent>(_accountDeletionCheckBox);
    on<ProfileAccountDeletionConfirmEvent>(_accountDeletionConfirm);
    on<ProfileSignOutConfirmEvent>(_signOutConfirm);
    on<PersonalDataPickImageEvent>(_selectImage);
  }

  void _selectImage(PersonalDataPickImageEvent event ,Emitter<ProfileState> emit){
    if(event.image!=null){
      emit(PersonalDataPickImageState(image: event.image,error: false));
    }else{
      emit(PersonalDataPickImageState(image: null,error: true));
    }
  }

  void _personalDataUpdate(PersonalDataUpdateProfileEvent event,Emitter<ProfileState> emit)async{
    try{
      emit(PersonalDataUpdateProfileState(loading: true, success: false, msg: "", user: event.user));
      ApiResponse? response= await updateUserUseCase(UpdateUserParam(data: event.data));
      if(response?.success==true){
        if(response!=null && response.data!=null){
          userModel=response.data;
          emit(PersonalDataUpdateProfileState(loading: false, success: true, msg: response.message ?? "User updated successfully", user: response.data));
        }
      }else{
        emit(PersonalDataUpdateProfileState(loading: false, success: false, msg: response?.message ?? "User not updated successfully", user: event.user));
      }

    }catch(e,stack){
      emit(PersonalDataUpdateProfileState(loading: false, success: false, msg: e.toString(), user: event.user));
    }
  }

  void _accountDeletionCheckBox(ProfileAccountDeletionCheckBoxEvent event , Emitter<ProfileState> emit){
    accountDeletionReason.entries.map((reason){
      if(reason.key==event.title){
       if(!accountDeletionReason[event.title]){
         accountDeletionReason[event.title]= !accountDeletionReason[event.title];
         selectedAccountDeletionReason=event.title;
       }else{
         accountDeletionReason[event.title]= !accountDeletionReason[event.title];
         selectedAccountDeletionReason=null;
       }
      }else{
        return  accountDeletionReason[reason.key]= false;
      }
    }).toList();
    emit(ProfileAccountDeletionCheckBoxState());
  }

  void _accountDeletionConfirm(ProfileAccountDeletionConfirmEvent event,Emitter<ProfileState> emit)async{
    emit(ProfileAccountDeletionConfirmState(isSuccess: false,isLoading: true));
    await Future.delayed(Duration(seconds: 2));
    //call api here and send reason why you delete account -----selectedAccountDeletionReason have a value
    emit(ProfileAccountDeletionConfirmState(isSuccess: true,isLoading: false));

  }

  void _signOutConfirm(ProfileSignOutConfirmEvent event,Emitter<ProfileState> emit)async{
    emit(ProfileSignOutConfirmState(isSuccess: false,isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    //remove local data base value
    AppSecureStorage.instance.clearBothToken();
    emit(ProfileSignOutConfirmState(isSuccess: true,isLoading: false));
  }


}
