import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../utils/k_images.dart';
import '../../../widget/custom_image.dart';
import '../../core/routes/route_names.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/primary_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
                      text: "Verify OTP",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Utils.verticalSpace(12.0),
                  SizedBox(
                    width: 293.h,
                    child: const Text(
                      'Please check your email or Phone to see the verification code.',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 14,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.57,
                      ),
                    ),
                  ),
                  Utils.verticalSpace(24),
                  Center(
                    child: Pinput(
                      length: 4,
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
                  Utils.verticalSpace(40.0),
                  PrimaryButton(
                      text: "Verify",
                      onPressed: (){
                        Navigator.pushNamed(
                            context, RouteNames.createNewPasswordScreen);
                      },
                      // onPressed: () {
                      //   showDialog(
                      //       context: context,
                      //       builder: (context) {
                      //         return FeedBackDialog(
                      //           image: KImages.thumbsIcon,
                      //           message: "Success",
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               const Text(
                      //                 'OTP verification is successful!',
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                   color: Color(0xFF535769),
                      //                   fontSize: 14,
                      //                   fontFamily: 'Work Sans',
                      //                   fontWeight: FontWeight.w500,
                      //                   height: 1.43,
                      //                 ),
                      //               ),
                      //               Utils.verticalSpace(24),
                      //               PrimaryButton(
                      //                   text: "Back To Login",
                      //                   onPressed: () {
                      //                     Navigator.pushNamedAndRemoveUntil(
                      //                         context,
                      //                         RouteNames.authenticationScreen,
                      //                         (route) => false);
                      //                   })
                      //             ],
                      //           ),
                      //         );
                      //       });
                      // }
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
