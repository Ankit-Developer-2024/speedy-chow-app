


import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:speedy_chow/core/localization/app_local.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async{


  final FlutterLocalization localization = FlutterLocalization.instance;
  //localization
  getIt.registerSingleton(localization);



}

void initFlutterLocalization() {
    getIt<FlutterLocalization>().init(
        mapLocales: [
          MapLocale('en',
              AppLocal.EN,
              countryCode: 'IN',

          )
        ],
        initLanguageCode: 'en');

}
