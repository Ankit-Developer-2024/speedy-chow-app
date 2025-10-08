part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class PasswordHiddenState extends AuthState {
  final bool isPassHidden;

  PasswordHiddenState({required this.isPassHidden});

  PasswordHiddenState copyWith({bool? isPassHidden}) {
    return PasswordHiddenState(isPassHidden: isPassHidden ?? this.isPassHidden);
  }

  @override
  List<Object?> get props => [isPassHidden];
}

final class AuthLoginState extends AuthState {
  final bool isLoading;
  final bool isSuccess;
  final String message;
  final AuthModels data;

  AuthLoginState({required this.isLoading, required this.isSuccess, required this.message, required this.data});

  @override
  List<Object?> get props => [isLoading, isSuccess,message,data];
}


final class AuthOpenRegisterViewState extends AuthState{
  @override
  List<Object?> get props =>[];
}

final class AuthOpenLoginViewState extends AuthState{
  @override
  List<Object?> get props =>[];
}

final class AuthRegisterState extends AuthState{
  final bool isAgree;
  final bool isLoading;
  final bool isSuccess;
  final String message;
  AuthRegisterState({required this.isAgree,required this.isSuccess,required this.message,required this.isLoading});


  @override
  List<Object?> get props =>[isAgree,isLoading,isSuccess,message];

}

final class AuthPolicyState extends AuthState{

  final bool isAgree;

  AuthPolicyState({required this.isAgree});

  AuthPolicyState copyWith({bool? isAgree}) {
    return AuthPolicyState(isAgree: isAgree ?? this.isAgree);
  }
  @override
  List<Object?> get props => [isAgree];
}

final class AuthForgotPasswordState extends AuthState{
  final DateTime timestamp;
  AuthForgotPasswordState() : timestamp = DateTime.now();
  @override
  List<Object?> get props =>[timestamp];
}

final class AuthEmailForgotPasswordState extends AuthState {
  final bool isLoading;
  final bool isSuccess;
  final String msg;

  AuthEmailForgotPasswordState({required this.isLoading,required this.isSuccess,required this.msg});

  @override
  List<Object?> get props => [isLoading, isSuccess,msg];
}

final class AuthIsOtpValidState extends AuthState{

  final bool isLoading;
  final bool isSuccess;
  final String msg;

  AuthIsOtpValidState({required this.isLoading,required this.isSuccess,required this.msg});

  @override
  List<Object?> get props =>[isSuccess,isLoading,msg];

}

class AuthTickOtpTimerState extends AuthState {
  final int otpSecondsRemaining;
  final bool canResendOtp;

  AuthTickOtpTimerState({
    this.otpSecondsRemaining = 0,
    this.canResendOtp = true,
  });

  AuthState copyWith({
    int? otpSecondsRemaining,
    bool? canResendOtp,
  }) {
    return AuthTickOtpTimerState(
      otpSecondsRemaining: otpSecondsRemaining ?? this.otpSecondsRemaining,
      canResendOtp: canResendOtp ?? this.canResendOtp,
    );
  }

  @override
  List<Object?> get props => [otpSecondsRemaining, canResendOtp];
}

final class AuthResetPasswordMatchState extends AuthState{
  final bool isMatch;

  AuthResetPasswordMatchState({required this.isMatch});

  AuthResetPasswordMatchState copyWith({bool? isMatch}) {
    return AuthResetPasswordMatchState(
      isMatch: isMatch ?? this.isMatch,
    );
  }

  @override
  List<Object?> get props =>[isMatch];
}

final class AuthResetPasswordState extends AuthState{

  final bool isLoading;
  final bool isSuccess;
  final String msg;

  AuthResetPasswordState({required this.isLoading,required this.isSuccess,required this.msg});

  @override
  List<Object?> get props =>[isSuccess,isLoading,msg];

}

final class AuthUserState extends AuthState{

  final bool isLoading;
  final bool isSuccess;
  final String message;

  AuthUserState({required this.isLoading, required this.isSuccess, required this.message});

  @override
  List<Object?> get props =>[isLoading,isSuccess,message];
}

final class AddAddressAuthState extends AuthState{
  final bool isLoading;
  final bool isSuccess;
  final String message;

  AddAddressAuthState({required this.isLoading, required this.isSuccess, required this.message});

  @override
  List<Object?> get props => [isLoading,isSuccess,message];

}

final class SelectDefaultAddressAuthState extends AuthState{
  final bool isLoading;
  final bool isSuccess;
  final String message;
  final int showAnimationIndex;

  SelectDefaultAddressAuthState({required this.isLoading, required this.isSuccess, required this.message,required this.showAnimationIndex});

  @override
  List<Object?> get props => [isLoading,isSuccess,message,showAnimationIndex];
}

final class FormIsDefaultAddressAuthState extends AuthState{
  final DateTime dateTime=DateTime.now();
  @override
  List<Object?> get props => [dateTime];
}

final class UserFetchAddressAuthState extends AuthState{
  final bool error;
  final bool loading;
  final String message;
  final String street;
  final String zipcode;
  final String country;
  final String state;
  final String city;

  UserFetchAddressAuthState({
    required this.street,
    required this.zipcode,
    required this.country,
    required this.state,
    required this.city,
    required this.error,
    required this.message,
    required this.loading,
  });
  @override
  List<Object?> get props => [street,zipcode,country,state,city,error,message,loading];
}
