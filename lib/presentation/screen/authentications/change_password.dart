import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_cubit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../features/ForgotPassword/cubit/forgot_password_state.dart';
import '../../../features/ForgotPassword/cubit/forgot_password_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late ForgotPasswordCubit fpCubit;

  @override
  void initState() {
    fpCubit = context.read<ForgotPasswordCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final email = fpCubit.state.email;
    final otp = fpCubit.state.otp;
    print('Email ====== $email');
    print('OTP ========= $otp');
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Password Change',
        visibleLeading: true,
      ),
      backgroundColor: scaffoldBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: Utils.symmetric(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Utils.verticalSpace(20.0),
              Center(
                child: CustomImage(
                  path: KImages.passwordImage,
                  width: 170.w,
                  height: 160.h,
                  fit: BoxFit.cover,
                ),
              ),
              Utils.verticalSpace(40.0),
              BlocBuilder<ForgotPasswordCubit, ForgotPasswordStateModel>(
                builder: (context, state) {
                  final validate = state.passwordState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormWidget(
                        label: 'New Password',
                        bottomSpace: 14.0,
                        child: TextFormField(
                          obscureText: state.showNewPass,
                          initialValue: state.newPass,
                          onChanged: fpCubit.newPass,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(color: borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(color: borderColor),
                            ),
                            hintText: 'New password',
                            suffixIcon: IconButton(
                              splashRadius: 18.0,
                              onPressed: () {
                                fpCubit.showNewPassword();
                              },
                              icon: Icon(
                                Icons.visibility_off_outlined,
                                color: blackColor.withOpacity(0.6),
                                size: 25,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      if (validate is ForgotPasswordFormValidateError) ...[
                        if (validate.errors.password.isNotEmpty)
                          FetchErrorText(text: validate.errors.password.first),
                      ],
                    ],
                  );
                },
              ),

              BlocBuilder<ForgotPasswordCubit, ForgotPasswordStateModel>(
                builder: (context, state) {
                  final validate = state.passwordState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormWidget(
                        label: 'Confirm Password',
                        bottomSpace: 14.0,
                        child: TextFormField(
                          obscureText: state.showConPass,
                          initialValue: state.conPass,
                          onChanged: fpCubit.conPass,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(color: borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(color: borderColor),
                            ),
                            hintText: 'Confirm password',
                            suffixIcon: IconButton(
                              splashRadius: 18.0,
                              onPressed: () {
                                fpCubit.showConPassword();
                              },
                              icon: Icon(
                                Icons.visibility_off_outlined,
                                color: blackColor.withOpacity(0.6),
                                size: 25,
                              ),
                            ),
                          ),

                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      if (validate is ForgotPasswordFormValidateError) ...[
                        if (validate.errors.confirmPassword.isNotEmpty)
                          FetchErrorText(
                            text: validate.errors.confirmPassword.first,
                          ),
                      ],
                    ],
                  );
                },
              ),

              Utils.verticalSpace(40),
              // BlocListener<ForgotPasswordCubit, ForgotPasswordStateModel>(
              //   listener: (context, state) {
              //     final changePass = state.passwordState;
              //
              //     print("===== State Type: ${changePass.runtimeType} =====");
              //
              //     // Loading state
              //     if (changePass is ForgotPasswordResetStateLoading) {
              //       Utils.loadingDialog(context);
              //       return;
              //     }
              //
              //     // Close loading dialog
              //     Utils.closeDialog(context);
              //
              //     // Error state
              //     if (changePass is SetPasswordStateError) {
              //       Utils.errorSnackBar(context, changePass.message);
              //     }
              //
              //     else if (changePass is PasswordResetStateUpdated) {
              //       Utils.showSnackBar(context, changePass.message);
              //
              //       fpCubit.clear();
              //       Navigator.pushNamedAndRemoveUntil(
              //         context,
              //         RouteNames.authenticationScreen,
              //         (route) => false,
              //       );
              //     }
              //   },
              //   child: PrimaryButton(
              //     text: 'Save',
              //     onPressed: () {
              //       fpCubit.updatePassword(email, otp);
              //     },
              //   ),
              // ),

              BlocListener<ForgotPasswordCubit, ForgotPasswordStateModel>(
                listener: (context, state) async {
                  final changePass = state.passwordState;
                  print("===== State Type: ${changePass.runtimeType} =====");

                  if (changePass is ForgotPasswordResetStateLoading) {
                    Utils.loadingDialog(context);
                    return;
                  }

                  if (Navigator.canPop(context)) {
                    Utils.closeDialog(context);
                  }

                  if (changePass is SetPasswordStateError) {
                    Utils.errorSnackBar(context, changePass.message);
                  } else if (changePass is PasswordResetStateUpdated) {
                    Utils.showSnackBar(context, changePass.message);
                    fpCubit.clear();

                    Future.delayed(const Duration(milliseconds: 300), () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteNames.authenticationScreen,
                            (route) => false,
                      );
                    });
                  }
                },
                child: PrimaryButton(
                  text: 'Save',
                  onPressed: () {
                    fpCubit.updatePassword(email, otp);
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
