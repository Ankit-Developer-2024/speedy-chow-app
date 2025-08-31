import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/features/auth/domain/enitites/address.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/payment_methods.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/user_delivery_address.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {

  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodBloc>().userModel = context.read<AuthBloc>().userModel;
    if(context.read<PaymentMethodBloc>().userModel!=null){
      List<Address> address=context.read<PaymentMethodBloc>().userModel!.addresses!.where((item)=>item.isDefault==true).toList();
      if(address.isNotEmpty)  context.read<PaymentMethodBloc>().addressModel=address[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.grey10.withAlpha(100),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            size: AppDimensions.size_18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.spacing_24,
            right: AppDimensions.spacing_24,
            top: AppDimensions.spacing_10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppDimensions.spacing_10,
            mainAxisSize: MainAxisSize.min,
            children: [
              UserDeliveryAddress(),
              PaymentMethods()
            ],
          ),
        ),
      ),
    );
  }
}
