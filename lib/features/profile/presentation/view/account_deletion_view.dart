import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/components/widgets/custonConfirmationDialogBox.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/profile_item_app_bar.dart';

class AccountDeletionView extends StatelessWidget {
  const AccountDeletionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileItemAppBar(
        title: AppLocal.requestAccountDeletion.getString(context),
      ),
      floatingActionButton:  BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (prev, curr) =>
        curr is ProfileAccountDeletionConfirmState,
        listener: (context, state) {
          if (state is ProfileAccountDeletionConfirmState) {
            if (state.isLoading) {
              customLoaderDialog(
                context: context,
                title: AppLocal.accountDeletionProcessStart.getString(context),
              );
            } else if (state.isSuccess) {
              context.pop();
              context.pop();
              customSnackBar(context,seconds:4 ,AppLocal.accountDeletionProcessStartSuccessfully.getString(context));
            } else if (!state.isSuccess && !state.isLoading) {
              context.pop();
              context.pop();
              customSnackBar(context, "Error");
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.size_24),
          child: Button(
            height: AppDimensions.size_64,
            onTap: () {
              context.read<ProfileBloc>().selectedAccountDeletionReason !=
                  null
                  ? customConfirmationDialogBox(
                context: context,
                title: AppLocal.confirmDelete.getString(context),
                msg: AppLocal.confirmDeleteSubTitle.getString(
                  context,
                ),
                rightButtonTitle: AppLocal.delete.getString(context),
                onPress: () {
                  context.read<ProfileBloc>().add(ProfileAccountDeletionConfirmEvent());
                },
              )
                  : customConfirmationDialogBox(
                context: context,
                title: AppLocal.confirmDeleteCheckBoxTitle.getString(
                  context,
                ),
                msg: AppLocal.confirmDeleteCheckBoxSubTitle.getString(
                  context,
                ),
                isLeftButtonRequired: false,
                rightButtonTitle: AppLocal.cancel.getString(context),
                onPress: () {
                  context.pop();
                },
              );
            },
            child: Center(
              child: Text(
                AppLocal.deleteAccount.getString(context),
                style: AppTextStyles.medium16P(color: AppColors.white),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppDimensions.spacing_24,
          right: AppDimensions.spacing_24,
          top: AppDimensions.spacing_10,
        ),
        child: Column(
          children: [
            Text(
              AppLocal.whyDeleteAccount.getString(context),
              style: AppTextStyles.semiBold18P(),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (prev, curr) =>
                  curr is ProfileAccountDeletionCheckBoxState,
              builder: (context, state) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ...context
                        .read<ProfileBloc>()
                        .accountDeletionReason
                        .entries
                        .map((reason) {
                          return SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: reason.value,
                                  onChanged: (val) {
                                    context.read<ProfileBloc>().add(
                                      ProfileAccountDeletionCheckBoxEvent(
                                        title: reason.key,
                                        isCheck: val!,
                                      ),
                                    );
                                  },
                                ),

                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 100,
                                  child: Text(
                                    reason.key,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    style: AppTextStyles.medium16P(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
