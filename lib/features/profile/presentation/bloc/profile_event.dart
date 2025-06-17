part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {}

final class ProfileDataOpenDatePickerEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}



final class ProfilePersonalDataSaveEvent extends ProfileEvent {
  final String? fullName;
  final String? dob;
  final String? gender;
  final String? phone;
  final String? email;

  ProfilePersonalDataSaveEvent({
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.email,
  });

  @override
  List<Object?> get props => [fullName,dob,gender,phone,email];
}
