import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/register/cubit/register_cubit.dart';
import 'package:foodigo/features/register/model/register_state_model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../features/register/cubit/register_state.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';
import 'components/social_btn_section.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegisterCubit rCubit;

  @override
  void initState() {
    super.initState();
    rCubit = context.read<RegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const bool isRemember = true;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const CustomImage(
          path: KImages.logo,
          height: 30,
        ),
      ),
      backgroundColor: scaffoldBackground,
      body: ListView(
        padding: Utils.symmetric(v: 20),
        children: [
          const CustomText(
            text: "Create an Account",
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
          Utils.verticalSpace(20.0),
          BlocBuilder<RegisterCubit, RegisterStateModel>(
            builder: (context, state) {
              final validate = state.registerState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormWidget(
                    label: 'Full Name',
                    bottomSpace: 16.0,
                    child: TextFormField(
                      initialValue: state.name,
                      onChanged: rCubit.changeName,
                      decoration: const InputDecoration(
                        fillColor: Color(0xffF8FAFC),
                        filled: true,
                        hintText: 'Full name',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Please enter a Name',
                        ),
                      ]),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  if (validate is RegisterValidateStateError) ...[
                    if (validate.errors.name.isNotEmpty)
                      FetchErrorText(text: validate.errors.name.first),
                  ]
                ],
              );
            },
          ),
          BlocBuilder<RegisterCubit, RegisterStateModel>(
            builder: (context, state) {
              final validate = state.registerState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormWidget(
                    label: 'Email',
                    bottomSpace: 16.0,
                    child: TextFormField(
                      initialValue: state.email,
                      onChanged: rCubit.changeEmail,
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
                  if (validate is RegisterValidateStateError) ...[
                    if (validate.errors.email.isNotEmpty)
                      FetchErrorText(text: validate.errors.email.first),
                  ]
                ],
              );
            },
          ),
          BlocBuilder<RegisterCubit, RegisterStateModel>(
            builder: (context, state) {
              final validate = state.registerState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormWidget(
                    label: 'Password',
                    bottomSpace: 14.0,
                    child: TextFormField(
                      initialValue: state.password,
                      obscureText: state.showPassword,
                      onChanged: rCubit.changePassword,
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
                        hintText: 'Enter Password',
                        suffixIcon: IconButton(
                          splashRadius: 18.0,
                          onPressed: () {
                            rCubit.showPassword();
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
                  if (validate is RegisterValidateStateError) ...[
                    if (validate.errors.password.isNotEmpty)
                      FetchErrorText(text: validate.errors.password.first),
                  ]
                ],
              );
            },
          ),
          BlocBuilder<RegisterCubit, RegisterStateModel>(
            builder: (context, state) {
              final validate = state.registerState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormWidget(
                    label: 'Confirm Password',
                    bottomSpace: 14.0,
                    child: TextFormField(
                      initialValue: state.confirmPassword,
                      obscureText: state.showConPassword,
                      onChanged: rCubit.changeConPassword,
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
                            rCubit.showConfirmPassword();
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
                  if (validate is RegisterValidateStateError) ...[
                    if (validate.errors.confirmPassword.isNotEmpty)
                      FetchErrorText(
                          text: validate.errors.confirmPassword.first),
                  ]
                ],
              );
            },
          ),
          BlocBuilder<RegisterCubit, RegisterStateModel>(
            builder: (context, state) {
              final validate = state.registerState;
              return Column(
                children: [
                  CustomFormWidget(
                    label: 'Phone Number',
                    bottomSpace: 4.0,
                    child: TextFormField(
                      initialValue: state.phone,
                      onChanged: rCubit.phoneNumber,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        fillColor: Color(0xffF8FAFC),
                        filled: true,
                        hintText: 'Enter Phone number',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Enter Phone number',
                        )
                      ]),
                    ),
                  ),
                  if (validate is RegisterValidateStateError) ...[
                    if (validate.errors.phone.isNotEmpty)
                      FetchErrorText(text: validate.errors.phone.first),
                  ]
                ],
              );
            },
          ),
          _buildAgree(context),
          Utils.verticalSpace(18),
          BlocListener<RegisterCubit, RegisterStateModel>(
            listener: (context, state) {
              final reg = state.registerState;
              if (reg is RegisterStateLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (reg is RegisterStateError) {
                  Utils.failureSnackBar(context, reg.message);
                } else if (reg is RegisterStateSuccess) {
                  Utils.successSnackBar(context, reg.message);
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.otpScreen, (route) => false);
                }
              }
            },
            child: PrimaryButton(
                text: "Sign Up",
                fontSize: 14,
                onPressed: () {
                  rCubit.userRegister();
                  // rCubit.clearAllField();
                }),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Utils.verticalSpace(24),
              const SocialBtn(),
              Utils.verticalSpace(16),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomText(
                      text: 'Already have an account? ',
                      fontSize: 16,
                      color: lightGrayColor,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteNames.authenticationScreen);
                      },
                      child: const CustomText(
                        text: 'Sign In',
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Utils.verticalSpace(20.0),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAgree(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterStateModel>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Checkbox(
              activeColor: primaryColor,
              value: rCubit.state.isActive,
              onChanged: (v) => rCubit.privacyPolicy(),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: 'I agree to the company ',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: lightGrayColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'Term of Service',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: redColor,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(
                      text: ' and ',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: lightGrayColor,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: redColor,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
