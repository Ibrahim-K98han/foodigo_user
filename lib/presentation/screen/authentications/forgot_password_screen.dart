import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_cubit.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state_model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../features/register/cubit/register_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/loading_widget.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late RegisterCubit rCubit;
  late ForgotPasswordCubit fpCubit;

  @override
  void initState() {
    super.initState();
    fpCubit = context.read<ForgotPasswordCubit>();
    rCubit = context.read<RegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(title: const CustomImage(path: KImages.logo, height: 30)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 0.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Utils.verticalSpace(30),
                  const SizedBox(
                    child: CustomText(
                      text: "Forgot Password",
                      fontSize: 24.0,
                      fontFamily: bold700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Utils.verticalSpace(12.0),
                  SizedBox(
                    width: Utils.vSize(290.0),
                    child: const Text(
                      'Enter your email or phone, we will send a verification code to email or phone',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.57,
                      ),
                    ),
                  ),
                  Utils.verticalSpace(24),
                  const Center(
                    child: CustomImage(
                      path: KImages.passwordImage,
                      height: 160,
                    ),
                  ),
                  Utils.verticalSpace(24),
                  BlocBuilder<ForgotPasswordCubit, ForgotPasswordStateModel>(
                    builder: (context, state) {
                      final validate = state.passwordState;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFormWidget(
                            label: 'Email',
                            bottomSpace: 4.0,
                            child: TextFormField(
                              initialValue: state.email,
                              onChanged: fpCubit.changeEmail,
                              decoration: const InputDecoration(
                                fillColor: Color(0xffF8FAFC),
                                filled: true,
                                hintText: 'Enter Email Address',
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Please enter a Email',
                                ),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          if (validate is ForgotPasswordFormValidateError) ...[
                            if (validate.errors.email.isNotEmpty)
                              FetchErrorText(text: validate.errors.email.first),
                          ],
                        ],
                      );
                    },
                  ),
                  Utils.verticalSpace(24),
                  BlocConsumer<ForgotPasswordCubit, ForgotPasswordStateModel>(
                    listener: (context, state) {
                      final password = state.passwordState;
                      if (password is ForgotPasswordStateError) {
                        Utils.errorSnackBar(context, password.message);
                      } else if (password is ForgotPasswordStateLoaded) {
                        Utils.showSnackBar(context, password.message);
                        Navigator.pushNamed(
                          context,
                          RouteNames.forgotOtpScreen,
                        );
                      }
                    },
                    builder: (context, state) {
                      final password = state.passwordState;
                      if (password is ForgotPasswordStateLoading) {
                        return const LoadingWidget();
                      }
                      return PrimaryButton(
                        text: 'Send Code',
                        onPressed: () {
                          Utils.closeKeyBoard(context);
                          fpCubit.forgotPasswordCode();
                        },
                      );
                    },
                  ),
                  Utils.verticalSpace(12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
