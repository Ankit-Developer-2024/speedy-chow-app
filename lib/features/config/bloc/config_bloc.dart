import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:speedy_chow/features/config/data/repository/config_repo_impl.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final ConfigRepoImpl configRepoImpl;
  ConfigBloc({
    required this.configRepoImpl
}) : super(ConfigState()) {
    on<LoadConfigEvent>(_loadConfig);
    on<SetIsAppInstallEvent>(_setIsAppInstall);
  }

  void _loadConfig(LoadConfigEvent event,Emitter<ConfigState> emit){
    //here any api that initially get default data of app
    bool? isInstall=configRepoImpl.getIsAppInstalled();
    emit(ConfigState(isAppInstall: isInstall));
  }

  void _setIsAppInstall(SetIsAppInstallEvent event,Emitter<ConfigState> emit){
    configRepoImpl.setIsAppInstalled(event.val);
    emit(ConfigState(isAppInstall: configRepoImpl.getIsAppInstalled()));
  }

}
