import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:speedy_chow/core/services/preferences/app_secure_storage.dart';

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

   String? selectedAccountDeletionReason;

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileDataOpenDatePickerEvent>(_openDatePicker);
    on<ProfilePersonalDataSaveEvent>(_personalDataSave);
    on<ProfileAccountDeletionCheckBoxEvent>(_accountDeletionCheckBox);
    on<ProfileAccountDeletionConfirmEvent>(_accountDeletionConfirm);
    on<ProfileSignOutConfirmEvent>(_signOutConfirm);
  }

  void _openDatePicker(
    ProfileDataOpenDatePickerEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileDataOpenDatePickerState());
  }

  void _personalDataSave(
    ProfilePersonalDataSaveEvent event,
    Emitter<ProfileState> emit,
  ) async {
     try{
       emit(ProfilePersonalDataSaveState(isLoading: true, isSuccess: false));
       await Future.delayed(Duration(seconds: 2));
       Map data = {
         "name": event.fullName,
         "dob": event.dob,
         "gender": event.gender,
         "phone": event.phone,
         "email": event.email,
       };
       //call api here
       emit(ProfilePersonalDataSaveState(isLoading: false, isSuccess: true));
     }catch(e){
       emit(ProfilePersonalDataSaveState(isLoading: false, isSuccess: false));
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
