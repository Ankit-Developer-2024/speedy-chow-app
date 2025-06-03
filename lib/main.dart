import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speedy_chow/app.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/core/util/config/app_secret_config.dart';
import 'package:speedy_chow/features/config/bloc/config_bloc.dart';
import 'package:speedy_chow/init_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  await initDependencies();

  AppSecretConfig(
    flavor: Flavor.dev,
    values: AppSecretValues(
      baseUrl: "https://--",
      timeOut: const Duration(seconds: 30),
    ),
  );

  await openHive();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ConfigBloc>(
        lazy: false,
        create: (_)=> getIt<ConfigBloc>()..add(LoadConfigEvent()))
  ], child: const MyApp()));
}

 openHive()async{
   Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  await Hive.openBox("speedyChow");
}
