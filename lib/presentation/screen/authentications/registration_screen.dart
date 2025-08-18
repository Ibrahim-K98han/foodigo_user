import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: const CustomImage(
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
              CustomFormWidget(
                label: 'Full Name',
                bottomSpace: 16.0,
                child: TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Color(0xffF8FAFC),
                    filled: true,
                    hintText: 'Full name',
                  ),
                ),
              ),
              CustomFormWidget(
                label: 'Email',
                bottomSpace: 16.0,
                child: TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Color(0xffF8FAFC),
                    filled: true,
                    hintText: 'Email',
                  ),
                ),
              ),
              CustomFormWidget(
                label: 'Password',
                bottomSpace: 14.0,
                child: TextFormField(
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
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      splashRadius: 18.0,
                      onPressed: () {},
                      icon:  Icon(
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
              CustomFormWidget(
                label: 'Confirm Password',
                bottomSpace: 10.0,
                child: TextFormField(
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
                    hintText: 'Confirm Password',
                    suffixIcon: IconButton(
                      splashRadius: 18.0,
                      onPressed: () {},
                      icon:  Icon(
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
              _buildAgree(context),
              Utils.verticalSpace(12),
              PrimaryButton(
                  text: "Sign Up",
                  fontSize: 14,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.registerOTPScreen,
                        arguments: 'register');
                  }),
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
          ),
        ),
      ),
    );
  }

  Widget _buildAgree(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Checkbox(
          activeColor: primaryColor,
          value: true,
          onChanged: (value) {},
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
  }
}
