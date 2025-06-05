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

  AuthLoginState({required this.isLoading,required this.isSuccess});

  AuthLoginState copyWith({bool? isLoading, bool? isSuccess}) {
    return AuthLoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess];
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