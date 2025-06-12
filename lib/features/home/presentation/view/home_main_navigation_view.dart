import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/cart/presentation/view/cart_view.dart';
import 'package:speedy_chow/features/home/presentation/view/home_view.dart';
import 'package:speedy_chow/features/profile/presentation/view/profile_view.dart';

class HomeMainNavigationView extends StatelessWidget {
  const HomeMainNavigationView({super.key,required this.child});
   final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBloc, NavigationState>(
     listener: (context,state){
       if(state is NavigationSelectViewState) {
         context.goNamed(state.currentRoute);
       }
     },
      builder: (context, state) {
        if(state is NavigationSelectViewState){
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppColors.black,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_rounded),
                  label: 'Profile',
                ),

              ],
              currentIndex: state.currentIndex,
              onTap: (val) {
                context.read<NavigationBloc>().add(NavigationTabChangedEvent(index: val));
              },
            ),
            body: child,
          );
        }
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.black,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,
            selectedLabelStyle: AppTextStyles.medium14P(),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded),
                label: 'Profile',
              ),

            ],
            currentIndex: 0,
            onTap: (val) {
              context.read<NavigationBloc>().add(NavigationTabChangedEvent(index: val));
            },
          ),
          body: child,
        );

      },
    );
  }
}


