import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_cubit.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../features/register/cubit/register_cubit.dart';
import '../../../features/register/cubit/register_state.dart';
import '../../../features/register/model/register_state_model.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_image.dart';
import '../../core/routes/route_names.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/primary_button.dart';

class RegisterOtpScreen extends StatefulWidget {
  const RegisterOtpScreen({super.key});

  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  late RegisterCubit rCubit;

  bool finishTime = true;

  @override
  void initState() {
    super.initState();
    rCubit = context.read<RegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final fpCubit = context.read<ForgotPasswordCubit>();
    final email = fpCubit.state.email;
    print('========$email');
    return Scaffold(
      appBar: AppBar(
        title: const CustomImage(
          path: KImages.logo,
          height: 30,
        ),
      ),
      body: BlocListener<RegisterCubit, RegisterStateModel>(
        listener: (context, state) {
          final otp = state.registerState;
          if (otp is RegisterOtpStateError) {
            Utils.failureSnackBar(context, otp.message);
          } else if (otp is RegisterOtpStateSuccess) {
            Utils.successSnackBar(context, otp.message);
            Navigator.pushNamed(context, RouteNames.changePasswordScreen);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 24.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                        length: 6,
                        separatorBuilder: (index) =>
                            SizedBox(width: Utils.hSize(12.0)),
                        defaultPinTheme: PinTheme(
                          height: Utils.vSize(60.0),
                          width: Utils.hSize(60.0),
                          textStyle: GoogleFonts.workSans(
                            fontSize: 20.0,
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
                        onChanged: (String code) {
                          rCubit.otpChange(code);
                        },
                        onCompleted: (String code) {
                          if (code.length == 6) {
                            rCubit.verifyRegOtp(email);
                          } else {
                            Utils.errorSnackBar(context, 'Enter 6 digit');
                          }
                        },
                      ),
                    ),
                    Utils.verticalSpace(24.0),
                    _countDownTime(),
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
      ),
    );
  }

  Widget _countDownTime() {
    if (finishTime) {
      return Align(
        alignment: Alignment.center,
        child: TimerCountdown(
          format: CountDownTimerFormat.secondsOnly,
          enableDescriptions: false,
          spacerWidth: 6.0,
          timeTextStyle: GoogleFonts.poppins(
            fontSize: 30.0,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
          colonsTextStyle: GoogleFonts.poppins(
            fontSize: 30.0,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
          endTime: DateTime.now().add(
            const Duration(seconds: 30),
          ),
          onEnd: () {
            print('finish');
            setState(() => finishTime = false);
          },
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const CustomText(
              text: 'Don\'t get verification code', fontSize: 14.0),
          GestureDetector(
            onTap: () => rCubit.resendVerificationCode(),
            child: const CustomText(
              text: 'Resend Code',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ],
      );
    }
  }
}
