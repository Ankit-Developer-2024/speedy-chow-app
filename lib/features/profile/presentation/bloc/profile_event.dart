part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {}

final class PersonalDataPickImageEvent extends ProfileEvent{
  final File? image;

  PersonalDataPickImageEvent({required this.image});
  @override
  List<Object?> get props =>[];

}

final class ProfileAccountDeletionCheckBoxEvent extends ProfileEvent{

  final bool isCheck;
  final String title;

  ProfileAccountDeletionCheckBoxEvent({required this.title , required this.isCheck});

  @override
  List<Object?> get props => [isCheck,title];
}

final class ProfileAccountDeletionConfirmEvent extends ProfileEvent{

  @override
  List<Object?> get props => [];
}

final class ProfileSignOutConfirmEvent extends ProfileEvent{

  @override
  List<Object?> get props => [];
}

final class PersonalDataUpdateProfileEvent extends ProfileEvent{
  final Map<String,dynamic> data;
  final UserModel user;

  PersonalDataUpdateProfileEvent({required this.data,required this.user});
  @override
  List<Object?> get props => [data,user];

}

