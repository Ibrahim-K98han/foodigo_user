import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_event.dart';
import 'package:foodigo/features/Login/bloc/login_state.dart';
import 'package:foodigo/features/Login/model/login_state_model.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';

import '../../../../utils/constraints.dart';
import '../../../features/GetProfile/cubit/get_profile_cubit.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';
import 'components/social_btn_section.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = context.read<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: CustomImage(
          path: KImages.logo,
          height: 30.h,
        ),
      ),
      backgroundColor: scaffoldBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: Utils.symmetric(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Utils.verticalSpace(20.0),
              const CustomText(
                text: "Welcome Back!",
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
              const CustomText(
                text: "Sign in to your account",
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
              Utils.verticalSpace(20.0),
              BlocBuilder<LoginBloc, LoginStateModel>(
                builder: (context, state) {
                  final login = state.loginState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormWidget(
                        label: 'Email',
                        child: TextFormField(
                          initialValue: state.email,
                          onChanged: (value) =>
                              loginBloc.add(LoginEventUserEmail(value)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffF8FAFC),
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
                            hintText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      if (login is LoginStateFormValidate) ...[
                        if (login.errors.email.isNotEmpty)
                          FetchErrorText(text: login.errors.email.first)
                      ]
                    ],
                  );
                },
              ),
              Utils.verticalSpace(16),
              BlocBuilder<LoginBloc, LoginStateModel>(
                builder: (context, state) {
                  return CustomFormWidget(
                    label: 'Password',
                    child: TextFormField(
                      initialValue: state.password,
                      onChanged: (value) =>
                          loginBloc.add(LoginEventPassword(value)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffF8FAFC),
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
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          splashRadius: 18.0,
                          onPressed: () {
                            loginBloc.add(ShowPasswordEvent(state.show));
                          },
                          icon: Icon(
                            state.show
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: blackColor.withOpacity(0.6),
                            size: 25,
                          ),
                        ),
                      ),
                      obscureText: state.show,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  );
                },
              ),
              BlocBuilder<LoginBloc, LoginStateModel>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: state.isActive,
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(Utils.radius(2.4))),
                            activeColor: primaryColor,
                            onChanged: (v) =>
                                loginBloc.add(LoginEventRememberMe()),
                          ),
                          const CustomText(
                            text: 'Remember me',
                            color: greyColor,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, RouteNames.forgotPasswordEmailPhoneScreen),
                        child: const CustomText(
                          text: 'Forgot Password?',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFE94222),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                },
              ),
              Utils.verticalSpace(24),
              BlocConsumer<LoginBloc, LoginStateModel>(
                listener: (context, login) {
                  final state = login.loginState;
                  if (state is LoginStateError) {
                    Utils.failureSnackBar(context, state.message);
                  } else if (state is LoginStateLoaded) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteNames.mainScreen, (route) => false);
                    context.read<GetProfileCubit>().getProfileData();
                  }
                },
                builder: (context, login) {
                  final state = login.loginState;
                  if (state is LoginStateLoading) {
                    return const LoadingWidget();
                  }
                  return PrimaryButton(
                    text: "Sign In",
                    fontSize: 14,
                    onPressed: () {
                      Utils.closeKeyBoard(context);
                      loginBloc.add(const LoginEventSubmit());
                      // Navigator.pushNamed(context, RouteNames.mainScreen);
                    },
                  );
                },
              ),
              Utils.verticalSpace(16),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomText(
                      text: 'Don\'t have an account? ',
                      fontSize: 16,
                      color: bottomNavIconColor,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteNames.registrationScreen);
                      },
                      child: const CustomText(
                        text: 'Sign Up',
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: settingsIconBgColor,
                      ),
                    ),
                  ],
                ),
              ),
              Utils.verticalSpace(50),
              const SocialBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
