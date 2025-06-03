

import 'package:speedy_chow/core/services/preferences/app_preferences.dart';
import 'package:speedy_chow/core/util/constant/storage_tags.dart';
import 'package:speedy_chow/features/config/data/local_source/config_local_source.dart';

class ConfigLocalSourceImpl implements ConfigLocalSource{

  @override
  bool? getIsAppInstalled()=> AppPreferences.instance.getValue(StorageTags.isAppInstalled);

  @override
  void setIsAppInstalled(bool val) =>AppPreferences.instance.putValue(StorageTags.isAppInstalled, val);
  
}