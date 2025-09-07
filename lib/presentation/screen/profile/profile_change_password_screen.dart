import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/ChangeProfilePass/cubit/change_profile_pass_cubit.dart';
import 'package:foodigo/features/ChangeProfilePass/cubit/change_profile_pass_state.dart';
import 'package:foodigo/features/ChangeProfilePass/model/change_profile_pass_state_model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';

class ProfileChangePasswordScreen extends StatefulWidget {
  const ProfileChangePasswordScreen({super.key});

  @override
  State<ProfileChangePasswordScreen> createState() =>
      _ProfileChangePasswordScreenState();
}

class _ProfileChangePasswordScreenState
    extends State<ProfileChangePasswordScreen> {
  late ChangeProfilePassCubit cppCubit;

  @override
  void initState() {
    cppCubit = context.read<ChangeProfilePassCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: 'Password Change', visibleLeading: true),
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
              BlocBuilder<ChangeProfilePassCubit, ChangeProfilePassStateModel>(
                builder: (context, state) {
                  final validate = state.changeProfilePassState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormWidget(
                        label: 'Current Password',
                        bottomSpace: 14.0,
                        child: TextFormField(
                          initialValue: state.currentPassword,
                          obscureText: state.showCurrentPassword,
                          onChanged: cppCubit.changeCurrentPassword,
                          decoration: InputDecoration(
                            fillColor: const Color(0xffF8FAFC),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: borderColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: borderColor,
                              ),
                            ),
                            hintText: 'Enter Current Password',
                            suffixIcon: IconButton(
                              splashRadius: 18.0,
                              onPressed: () {
                                cppCubit.showCurrentPassword();
                              },
                              icon: Icon(
                                state.showCurrentPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: blackColor.withOpacity(0.6),
                                size: 25,
                              ),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Please enter a Password',
                            ),
                          ]),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      if (validate is ChangeProfilePassValidateStateError) ...[
                        if (validate.errors.currentPassword.isNotEmpty)
                          FetchErrorText(
                              text: validate.errors.currentPassword.first),
                      ]
                    ],
                  );
                },
              ),
              Utils.verticalSpace(10),
              BlocBuilder<ChangeProfilePassCubit, ChangeProfilePassStateModel>(
                builder: (context, state) {
                  final validate = state.changeProfilePassState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormWidget(
                        label: 'New Password',
                        bottomSpace: 14.0,
                        child: TextFormField(
                          initialValue: state.password,
                          obscureText: state.showPassword,
                          onChanged: cppCubit.changeNewPassword,
                          decoration: InputDecoration(
                            fillColor: const Color(0xffF8FAFC),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: borderColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: borderColor,
                              ),
                            ),
                            hintText: 'Enter New Password',
                            suffixIcon: IconButton(
                              splashRadius: 18.0,
                              onPressed: () {
                                cppCubit.showPassword();
                              },
                              icon: Icon(
                                state.showPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: blackColor.withOpacity(0.6),
                                size: 25,
                              ),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Please enter a Password',
                            ),
                          ]),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      if (validate is ChangeProfilePassValidateStateError) ...[
                        if (validate.errors.newPassword.isNotEmpty)
                          FetchErrorText(
                              text: validate.errors.newPassword.first),
                      ]
                    ],
                  );
                },
              ),
              Utils.verticalSpace(10),
              BlocBuilder<ChangeProfilePassCubit, ChangeProfilePassStateModel>(
                builder: (context, state) {
                  final validate = state.changeProfilePassState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormWidget(
                        label: 'Confirm Password',
                        bottomSpace: 14.0,
                        child: TextFormField(
                          initialValue: state.confirmPassword,
                          obscureText: state.showConPassword,
                          onChanged: cppCubit.changeConfirmPassword,
                          decoration: InputDecoration(
                            fillColor: const Color(0xffF8FAFC),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: borderColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: borderColor,
                              ),
                            ),
                            hintText: 'Enter Confirm Password',
                            suffixIcon: IconButton(
                              splashRadius: 18.0,
                              onPressed: () {
                                cppCubit.showConfirmPassword();
                              },
                              icon: Icon(
                                state.showConPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: blackColor.withOpacity(0.6),
                                size: 25,
                              ),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Please enter a Password',
                            ),
                          ]),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      if (validate is ChangeProfilePassValidateStateError) ...[
                        if (validate.errors.confirmPassword.isNotEmpty)
                          FetchErrorText(
                              text: validate.errors.confirmPassword.first),
                      ]
                    ],
                  );
                },
              ),
              Utils.verticalSpace(40),
              BlocListener<ChangeProfilePassCubit, ChangeProfilePassStateModel>(
                listener: (context, state) {
                  final reg = state.changeProfilePassState;
                  if (reg is ChangeProfilePassStateLoading) {
                    Utils.loadingDialog(context);
                  } else {
                    Utils.closeDialog(context);
                    if (reg is ChangeProfilePassStateError) {
                      Utils.failureSnackBar(context, reg.message);
                    } else if (reg is ChangeProfilePassStateSuccess) {
                      Utils.successSnackBar(context, reg.message);
                      Navigator.pop(context);
                    }
                  }
                },
                child: PrimaryButton(
                  text: "Save",
                  fontSize: 16,
                  onPressed: () {
                    cppCubit.changeProfilePass();
                    cppCubit.clearAllField();
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
