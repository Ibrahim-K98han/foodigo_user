import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';
import 'components/social_btn_section.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const CustomImage(
          path: KImages.logo,
          height: 30,
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
              CustomFormWidget(
                label: 'Email',
                child: TextFormField(
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
                ),
              ),
              Utils.verticalSpace(16),
              CustomFormWidget(
                label: 'Password',
                child: TextFormField(
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.visibility_off_outlined,
                        color: blackColor.withOpacity(0.6),
                        size: 25,
                      ),
                    ),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              _buildRemember(context),
              Utils.verticalSpace(24),
              PrimaryButton(
                  text: "Sign In",
                  fontSize: 14,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.mainScreen);
                  }),
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

  Widget _buildRemember(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: true,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(Utils.radius(2.4))),
                activeColor: primaryColor,
                onChanged: (bool? val) {}),
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
  }
}
