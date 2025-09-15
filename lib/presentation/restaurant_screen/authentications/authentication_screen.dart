import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constraints.dart';
import '../../../features/restaurant_features/Login/bloc/restaurant_login_bloc.dart';
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
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: Utils.symmetric(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
                bottomSpace: 16.0,
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffF8FAFC),
                    hintText: 'email',
                  ),
                ),
              ),
              CustomFormWidget(
                label: 'Password',
                bottomSpace: 14.0,
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
                    hintText: 'password',
                    suffixIcon: IconButton(
                      splashRadius: 18.0,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.visibility_off_outlined,
                        color: blackColor,
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
              const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: 'Join as ',
                      fontSize: 16,
                    ),
                    CustomText(
                      text: 'Restaurant',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ],
                ),
              ),
              Utils.verticalSpace(size.height * 0.13),
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
            Padding(
              padding: Utils.only(top: 0.0),
              child: Checkbox(
                  value: true,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(Utils.radius(2.4))),
                  activeColor: primaryColor,
                  onChanged: (bool? val) {}),
            ),
            const CustomText(
              text: 'Remember me',
              color: greyColor,
              height: 1.6,
            ),
          ],
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, RouteNames.forgotPassScreen),
          child: const CustomText(
            text: 'Forgot Password',
            fontWeight: FontWeight.w600,
            color: Color(0xFFE94222),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
