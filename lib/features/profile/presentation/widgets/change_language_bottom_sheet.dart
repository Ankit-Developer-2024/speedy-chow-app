import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/config/bloc/config_bloc.dart';
import 'package:speedy_chow/init_dependencies.dart';

Future<dynamic> changeLanguageBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.transparent,
    builder: (_) {
      return CustomAddressAuthBottomSheet();
    },
  );
}

class CustomAddressAuthBottomSheet extends StatelessWidget {
  const CustomAddressAuthBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.spacing_10,
            children: [
              IconButton.filledTonal(
                color: AppColors.black,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.white),
                ),
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.close_sharp),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(AppDimensions.spacing_24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimensions.radius_16),
                    topRight: Radius.circular(AppDimensions.radius_16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppDimensions.spacing_6,
                  children: [
                    Text(AppLocal.changeLanguage.getString(context),style: AppTextStyles.semiBold24P(),),
                    Text(AppLocal.changeLanguageAbout.getString(context),style: AppTextStyles.medium14P(color: AppColors.grey500),),
                  SizedBox(height: AppDimensions.spacing_8,),
                  Button(onTap: (){
                   getIt<FlutterLocalization>().translate('en');
                   getIt<ConfigBloc>().add(ChangeLanguageEvent(locale: Locale('en')));
                 },
                      border: getIt<FlutterLocalization>().currentLocale?.languageCode=="en" ?null : BoxBorder.all(
                          color: AppColors.black
                      ),
                      color: getIt<FlutterLocalization>().currentLocale?.languageCode=="en" ?null : AppColors.white   ,
                      child: Center(child: Text(AppLocal.english.getString(context),style: AppTextStyles.medium16P(
                      color:  getIt<FlutterLocalization>().currentLocale?.languageCode=="en" ? AppColors.white :AppColors.black
                  ),))),
                 Button(onTap: (){
                   getIt<ConfigBloc>().add(ChangeLanguageEvent(locale: Locale('hi')));
                   getIt<FlutterLocalization>().translate('hi');
                 },
                     border: getIt<FlutterLocalization>().currentLocale?.languageCode=="hi" ?null : BoxBorder.all(
                       color: AppColors.black
                     ),
                     color: getIt<FlutterLocalization>().currentLocale?.languageCode=="hi" ?null : AppColors.white   ,
                     child: Center(child: Text(AppLocal.hindi.getString(context),style: AppTextStyles.medium16P(
                         color:  getIt<FlutterLocalization>().currentLocale?.languageCode=="hi" ? AppColors.white :AppColors.black
                     ),))),
                  ],
                )
              )
            ]
        ),
      ),
    );
  }
}

