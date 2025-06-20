part of 'auth_bloc.dart';


sealed class AuthEvent extends Equatable {}

final class PasswordHiddenEvent extends AuthEvent{
  final bool isPassHidden;

  PasswordHiddenEvent({required this.isPassHidden});

  @override
  List<Object?> get props =>[isPassHidden];

}

final class AuthLoginEvent extends AuthEvent{

  final String email;
  final String password;

  AuthLoginEvent({required this.email,required this.password});

  @override
  List<Object?> get props => [email,password];

}

final class AuthOpenRegisterViewEvent extends AuthEvent{
  @override
  List<Object?> get props =>[];
}

final class AuthOpenLoginViewEvent extends AuthEvent{
  @override
  List<Object?> get props =>[];
}

final class AuthRegisterEvent extends AuthEvent{
  final String email;
  final String password;
  final String userName;
  AuthRegisterEvent({required this.email,required this.password,required this.userName});

  @override
  List<Object?> get props =>[password,email,userName];

}

final class AuthPolicyEvent extends AuthEvent{

  final bool isAgree;

  AuthPolicyEvent({required this.isAgree});

  @override
  List<Object?> get props =>[isAgree];

}

final class AuthForgotPasswordEvent extends AuthEvent{
  @override
  List<Object?> get props =>[];
}

final class AuthEmailForgotPasswordEvent extends AuthEvent{

  final String email;

  AuthEmailForgotPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];

}

final class AuthIsOtpValidEvent extends AuthEvent {

  final String otp;

  AuthIsOtpValidEvent({required this.otp});

  @override
  List<Object?> get props => [otp];

}

final class AuthStartOtpTimerEvent extends AuthEvent{
  @override
  List<Object?> get props => [];

}

class AuthTickOtpTimerEvent extends AuthEvent {
  final int secondsLeft;
  AuthTickOtpTimerEvent(this.secondsLeft);

  @override
  List<Object?> get props => [secondsLeft];
}


final class AuthResetPasswordEvent extends AuthEvent{

  final String newPassword;
  final String newConfirmPassword;

  AuthResetPasswordEvent({required this.newPassword,required this.newConfirmPassword});

  @override
  List<Object?> get props => [newPassword,newConfirmPassword];

}
