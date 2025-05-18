import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
          body:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: (){
                      context.goNamed(AppRoutes.login);
                    },
                    child: Text("Sdc")),
                Image.asset(getLocalJpg("splash_bg_image")),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(getLocalJpg("splash_bg_image")),fit: BoxFit.fill)
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
