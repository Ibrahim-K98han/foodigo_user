import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';
import 'components/social_btn_section.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  const CustomImage(
          path: KImages.logo,
          height: 30,
        ),
      ),
      backgroundColor: scaffoldBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: "Create an Account",
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
              Utils.verticalSpace(20.0),
              CustomTextField(
                label: 'Name ',
                hintText: 'david John',
              ),
              CustomTextField(
                label: 'Email Address',
                hintText: 'david@gmail.com',
              ),
              CustomFormWidget(
                label: 'Password',
                bottomSpace: 14.0,
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: BorderSide(
                        color: borderColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: BorderSide(
                        color: borderColor,
                      ),
                    ),
                    hintText: 'password',
                    suffixIcon: IconButton(
                      splashRadius: 18.0,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.visibility,
                        color: blackColor,
                      ),
                    ),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),

              _buildAgree(context),
              Utils.verticalSpace(12),
              PrimaryButton(
                  text: "Sign Up",
                  fontSize: 14,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.verificationScreen);
                  }),
              Utils.verticalSpace(24),
              const SocialBtn(),
              Utils.verticalSpace(16),
              Center(
                child: Text.rich(TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                      letterSpacing: 1,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign In",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushNamed(
                              context, RouteNames.authenticationScreen),
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE94222),
                          fontFamily: bold700,
                          letterSpacing: 1,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ])),
              ),
              Utils.verticalSpace(20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgree(BuildContext context) {
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
             Text.rich(TextSpan(
                 text: "i agree to the company ",
                 style: TextStyle(
                   fontSize: 14.sp,
                   fontWeight: FontWeight.w400,
                   color: textColor,
                   letterSpacing: 1,
                   overflow: TextOverflow.ellipsis
                 ),
                 children: [
                   TextSpan(
                     text: "Terms of Service",
                     recognizer: TapGestureRecognizer()
                       ..onTap = () => Navigator.pushNamed(
                           context, RouteNames.authenticationScreen),
                     style: const TextStyle(
                       fontSize: 15.0,
                       fontWeight: FontWeight.w700,
                       color: Color(0xFFE94222),
                       fontFamily: bold700,
                       letterSpacing: 1,
                       decoration: TextDecoration.underline,
                     ),
                   ),
                   // TextSpan(
                   //   text: "Privacy Policy",
                   //   recognizer: TapGestureRecognizer()
                   //     ..onTap = () => Navigator.pushNamed(
                   //         context, RouteNames.authenticationScreen),
                   //   style: const TextStyle(
                   //     fontSize: 15.0,
                   //     fontWeight: FontWeight.w700,
                   //     color: Color(0xFFE94222),
                   //     fontFamily: bold700,
                   //     letterSpacing: 1,
                   //     decoration: TextDecoration.underline,
                   //   ),
                   // )
                 ])),
          ],
        ),

      ],
    );
  }
}
