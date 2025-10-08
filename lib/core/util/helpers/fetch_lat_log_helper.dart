import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speedy_chow/core/components/widgets/disable_permission_alert_box.dart';
import 'package:speedy_chow/core/localization/app_local.dart';

class FetchLatLogHelper{

  static Future<Position?> getCurrentLatLog({required BuildContext context})async{
      bool status = await locationPermission(context:context);

      if(status==false) return null;

      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      return position;
  }

  static Future<bool> locationPermission({required BuildContext context})async{
    try{
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if(!serviceEnabled){
        permission = await Geolocator.requestPermission();
        if(permission == LocationPermission.deniedForever){
          if(context.mounted){
            showAdaptiveDialog(context: context, builder: (context)=> DisablePermissionAlertBox(title: AppLocal.locationPermission.getString(context), desc: AppLocal.locationPermissionDesc.getString(context)));
          }
         return false;
        }else if(permission == LocationPermission.denied){
          if(context.mounted){
            await locationPermission(context: context);
          }
          return false;
        }else{
          return true;
        }
      }else{
        return true;
      }
    }catch(err){
      return false;
    }
  }



}