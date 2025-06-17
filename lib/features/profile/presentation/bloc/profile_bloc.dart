import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileDataOpenDatePickerEvent>(_openDatePicker);
    on<ProfilePersonalDataSaveEvent>(_personalDataSave);
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
       emit(ProfilePersonalDataSaveState(isLoading: false, isSuccess: true));
     }catch(e){
       emit(ProfilePersonalDataSaveState(isLoading: false, isSuccess: false));
     }
  }
}
