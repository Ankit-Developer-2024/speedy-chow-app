part of 'splash_bloc.dart';


sealed class SplashEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SplashViewCompleteEvent extends SplashEvent{}

final class SplashOneTimeUiEvent extends SplashEvent{

  @override
  List<Object?> get props => [];
}

final class SplashOneTimeUiSkipEvent extends SplashEvent{}

