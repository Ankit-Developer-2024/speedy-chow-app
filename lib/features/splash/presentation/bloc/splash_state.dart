part of 'splash_bloc.dart';


sealed class SplashState extends Equatable {}

final class SplashInitial extends SplashState {
  @override
  List<Object?> get props => [];
}

final class ShowLoginViewState extends SplashState{
  @override
  List<Object?> get props => [];
}

final class ShowOneTimeUiState extends SplashState{
  @override
  List<Object?> get props => [];
}

final class SplashOneTimeUiState extends SplashState{

  final int introPart;

  SplashOneTimeUiState({required this.introPart});

  @override
  List<Object?> get props => [introPart];
}


final class SplashOneTimeUiCompleteState extends SplashState{

  SplashOneTimeUiCompleteState();

  @override
  List<Object?> get props => [];
}