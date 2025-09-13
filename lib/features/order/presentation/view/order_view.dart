import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
import 'package:speedy_chow/core/components/widgets/h_axis_line.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/order/presentation/bloc/order_bloc.dart';
import 'package:speedy_chow/features/order/presentation/widgets/empty_order.dart';
import 'package:speedy_chow/features/order/presentation/widgets/order_item.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(FetchOrderEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.grey10.withAlpha(100),
        leading: IconButton(
          onPressed: () {
            context.read<NavigationBloc>().add(
              NavigationTabChangedEvent(index: 0),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            size: AppDimensions.size_18,
          ),
        ),
        title: Text(
          AppLocal.myOrder.getString(context),
          style: AppTextStyles.semibold18P(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppDimensions.spacing_24,
          right: AppDimensions.spacing_24,
          top: AppDimensions.spacing_10,
        ),
        child: BlocConsumer<OrderBloc, OrderState>(
          listenWhen: (prev,curr)=>curr is FetchOrderState,
          listener: (context, state) {
             if(state is FetchOrderState){
               if(state.loading==true){
                 customLoaderDialog(context: context, title: AppLocal.loading.getString(context));
               }
               else {
                 context.pop();
               }
             }
          },
          buildWhen: (prev,curr)=>curr is FetchOrderState,
          builder: (context, state) {
             if(state is FetchOrderState){
                if(state.loading==true){
                  return SizedBox.shrink();
                }
                else if(state.success==true && state.orders.isNotEmpty ){
                  return  ListView.separated(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return OrderItem(order: state.orders[index],);
                      },
                      separatorBuilder: (context, index) {
                        return HAxisLine();
                      },
                      );
                }else if(state.success==true && state.orders.isEmpty){
                  return EmptyOrder();
                }else{
                  return Center(child: Text(state.message),);
                }
             }else{
               return Center(child: Text(AppLocal.loading.getString(context)),);
             }
          },
        ),
      ),
    );
  }
}
