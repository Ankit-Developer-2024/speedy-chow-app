part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileDataOpenDatePickerState extends ProfileState{
  final DateTime timestamp = DateTime.now();

  @override
  List<Object?> get props => [timestamp];
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

