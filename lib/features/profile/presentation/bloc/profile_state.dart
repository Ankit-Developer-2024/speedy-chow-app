part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class PersonalDataPickImageState extends ProfileState{
  final File? image;
  final bool error;

  PersonalDataPickImageState({required this.image,required this.error});
  @override
  List<Object?> get props =>[image,error];

}

final class ProfilePersonalDataSaveState extends ProfileState {
  final bool isLoading;
  final bool isSuccess;

  ProfilePersonalDataSaveState({
    required this.isLoading,
    required this.isSuccess,
  });

  @override
  List<Object?> get props => [isLoading,isSuccess];
}

final class ProfileAccountDeletionCheckBoxState extends ProfileState{
  final DateTime timestamp = DateTime.now();

  @override
  List<Object?> get props => [timestamp];
}

final class ProfileAccountDeletionConfirmState extends ProfileState{
  final bool isLoading;
  final bool isSuccess;

  ProfileAccountDeletionConfirmState({
    required this.isLoading,
    required this.isSuccess,
  });

  @override
  List<Object?> get props => [isLoading,isSuccess];
}

final class ProfileSignOutConfirmState extends ProfileState{
  final bool isLoading;
  final bool isSuccess;

  ProfileSignOutConfirmState({
    required this.isLoading,
    required this.isSuccess,
  });

  @override
  List<Object?> get props => [isLoading,isSuccess];
}

final class PersonalDataUpdateProfileState extends ProfileState{
  final bool loading;
  final bool success;
  final String msg;
  final UserModel user;

  PersonalDataUpdateProfileState({required this.loading,required this.success,required this.msg,required this.user});
  @override
  List<Object?> get props => [loading,success,msg,user];

}


