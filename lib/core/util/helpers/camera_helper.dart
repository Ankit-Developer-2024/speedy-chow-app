import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speedy_chow/core/components/widgets/disable_permission_alert_box.dart';
import 'package:speedy_chow/core/localization/app_local.dart';

class CameraHelper{
  static Future<File?> pickImage({required BuildContext context}) async{
    bool status= await cameraPermission(context: context);
    if(status==false){return null;}
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery,);
    if(image!=null){
       return File(image.path);
    }
    return null;
  }

 static Future<bool> cameraPermission({required BuildContext context})async{

   try{
     var status=await Permission.photos.request();
     if(status.isPermanentlyDenied){
       showAdaptiveDialog(context: context, builder: (context)=> DisablePermissionAlertBox(title: AppLocal.galleryPermission.getString(context), desc: AppLocal.galleryPermissionDesc.getString(context)));
       return false;
     }else if(status.isDenied){
       await cameraPermission(context: context);
       return false;
     }else{
       return true;
     }
   }catch(e){
    // print(e.toString());
     return false;
   }

  }


}