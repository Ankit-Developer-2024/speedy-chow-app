

import 'package:speedy_chow/features/config/data/local_source/config_local_source_impl.dart';
import 'package:speedy_chow/features/config/data/repository/config_repo.dart';

class ConfigRepoImpl implements ConfigRepo{
  final ConfigLocalSourceImpl _localSourceImpl=ConfigLocalSourceImpl();
  @override
  bool? isAppInstalled() => _localSourceImpl.isAppInstalled();

}