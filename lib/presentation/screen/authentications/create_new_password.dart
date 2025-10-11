import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_cubit.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  late ForgotPasswordCubit fpCubit;

  @override
  void initState() {
    super.initState();
    fpCubit = context.read<ForgotPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final email = fpCubit.state.email;
    final otp = fpCubit.state.code;
    print('email====================$email');
    print('otp====================$otp');
    return Scaffold(
      appBar: AppBar(title: const CustomImage(path: KImages.logo, height: 30)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  const CustomImage(path: KImages.updatePassword),
                Utils.verticalSpace(30),
                const SizedBox(
                  child: CustomText(
                    text: "Set your New Password",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Utils.verticalSpace(16),
                SizedBox(
                  width: 293.h,
                  child: const Text(
                    'Don’t worry! it happens. Please enter the address associated with your account',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 14,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.57,
                    ),
                  ),
                ),
                Utils.verticalSpace(16),
                const Center(
                  child: CustomImage(path: KImages.passwordImage, height: 160),
                ),
                Utils.verticalSpace(16),
                CustomFormWidget(
                  label: 'Password',
                  bottomSpace: 14.0,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'password',
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
                CustomFormWidget(
                  label: 'Confirm Password',
                  bottomSpace: 30.0,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
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
                PrimaryButton(
                  text: "Set New Password",
                  fontSize: 14,
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.authenticationScreen,
                      (route) => false,
                    );
                  },
                ),
                Utils.verticalSpace(12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
