import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speedy_chow/app.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/core/util/config/app_secret_config.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/config/bloc/config_bloc.dart';
import 'package:speedy_chow/init_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  await initDependencies();

  AppSecretConfig(
    flavor: Flavor.dev,
    values: AppSecretValues(
      baseUrl: "http://192.168.43.81:3000/",
      timeOut: const Duration(seconds: 30),
    ),
  );

  await openHive();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ConfigBloc>(
        lazy: false,
        create: (_)=> getIt<ConfigBloc>()..add(LoadConfigEvent())
    ),
    BlocProvider<AuthBloc>(
        lazy: false,
        create: (_)=> getIt<AuthBloc>()
    ),
    BlocProvider<NavigationBloc>(
        lazy: false,
        create: (_)=> getIt<NavigationBloc>()
    ),
  ], child: const MyApp()));
}

 openHive()async{
   Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  await Hive.openBox("speedyChow");
}
