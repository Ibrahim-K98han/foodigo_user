import 'package:flutter/material.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                  const Center(child: CustomImage(path: KImages.passwordImage,height: 160,)),
                  Utils.verticalSpace(24),
                  CustomFormWidget(
                    label: 'Email or Phone',
                    bottomSpace: 20.0,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'email or phone number',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Utils.verticalSpace(24),
                  PrimaryButton(
                      text: "Send Code",
                      fontSize: 16,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RouteNames.otpScreen);
                      }),
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
