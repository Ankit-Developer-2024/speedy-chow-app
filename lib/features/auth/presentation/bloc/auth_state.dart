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
  AuthRegisterState({required this.isAgree,required this.isSuccess,required this.isLoading});

  AuthRegisterState copyWith({bool? isLoading,bool? isSuccess,bool? isAgree}) {
    return AuthRegisterState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
      isAgree: isAgree ?? this.isAgree
    );
  }

  @override
  List<Object?> get props =>[isAgree,isLoading,isSuccess];

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

  AuthEmailForgotPasswordState({required this.isLoading,required this.isSuccess});

  AuthEmailForgotPasswordState copyWith({bool? isLoading, bool? isSuccess}) {
    return AuthEmailForgotPasswordState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess];
}

final class AuthIsOtpValidState extends AuthState{

  final bool isLoading;
  final bool isSuccess;

  AuthIsOtpValidState({required this.isLoading,required this.isSuccess});

  AuthIsOtpValidState copyWith({bool? isLoading, bool? isSuccess}) {
    return AuthIsOtpValidState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess
    );
  }

  @override
  List<Object?> get props =>[isSuccess,isLoading];

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

  AuthResetPasswordState({required this.isLoading,required this.isSuccess});

  AuthResetPasswordState copyWith({bool? isLoading, bool? isSuccess}) {
    return AuthResetPasswordState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess
    );
  }

  @override
  List<Object?> get props =>[isSuccess,isLoading];

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
