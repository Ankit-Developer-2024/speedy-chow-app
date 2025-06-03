import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/app.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/core/util/config/app_secret_config.dart';
import 'package:speedy_chow/init_dependencies.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  await initDependencies();



  AppSecretConfig(
    flavor: Flavor.dev,
    values: AppSecretValues(baseUrl: "https://--", timeOut: const Duration(seconds: 30))
  );

  runApp(const MyApp());
}



