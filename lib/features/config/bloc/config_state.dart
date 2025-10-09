part of 'config_bloc.dart';


class ConfigState extends Equatable {
  final bool? isAppInstall;

  const ConfigState({
    this.isAppInstall,
});

  ConfigState copyWith({bool? isAppInstall}){
    return ConfigState(
      isAppInstall:isAppInstall ?? this.isAppInstall
    );
  }

  @override
  List<Object?> get props => [isAppInstall];
}


final class ChangeLanguageState extends ConfigState{
  final Locale locale;

  const ChangeLanguageState({required this.locale});
  @override
  List<Object?> get props => [locale];

}