part of 'config_bloc.dart';

sealed class ConfigEvent extends Equatable {}

final class LoadConfigEvent extends ConfigEvent{

  @override
  List<Object?> get props => [];
}

final class SetIsAppInstallEvent extends ConfigEvent{
    final bool val;

     SetIsAppInstallEvent(this.val);

  @override
  List<Object?> get props => [val];
}

final class ChangeLanguageEvent extends ConfigEvent{
  final Locale locale;

   ChangeLanguageEvent({required this.locale});
  @override
  List<Object?> get props => [locale];

}
