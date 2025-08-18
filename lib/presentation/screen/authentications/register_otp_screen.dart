import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../utils/k_images.dart';
import '../../../widget/custom_image.dart';
import '../../core/routes/route_names.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/primary_button.dart';

class RegisterOtpScreen extends StatelessWidget {
  const RegisterOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomImage(
          path: KImages.logo,
          height: 30,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 24),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SvgPicture.asset(KImages.otpVerify),
                  Utils.verticalSpace(30),
                  const SizedBox(
                    child: CustomText(
                      text: "Verify OTP!",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Utils.verticalSpace(12.0),
                  SizedBox(
                    width: 293.h,
                    child: const CustomText(
                      text:
                          'Please check your email or Phone to see the verification code.',
                      fontSize: 14,
                      color: lightGrayColor,
                    ),
                  ),
                  Utils.verticalSpace(24),
                  Center(
                    child: Pinput(
                      length: 4,
                      separatorBuilder: (index) =>
                          SizedBox(width: Utils.hSize(16.0)),
                      defaultPinTheme: PinTheme(
                        height: Utils.vSize(60.0),
                        width: Utils.hSize(60.0),
                        textStyle: GoogleFonts.workSans(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.1),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (String code) {},
                      onCompleted: (String code) {},
                    ),
                  ),
                  Utils.verticalSpace(24.0),
                  const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: 'Resend Code in ',
                          fontSize: 16,
                          color: lightGrayColor,
                        ),
                        CustomText(
                          text: '00:48',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ],
                    ),
                  ),

                  Utils.verticalSpace(24.0),
                  PrimaryButton(
                    text: "Verify",
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteNames.authenticationScreen);
                    },
                  ),
                  Utils.verticalSpace(24),
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
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
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
