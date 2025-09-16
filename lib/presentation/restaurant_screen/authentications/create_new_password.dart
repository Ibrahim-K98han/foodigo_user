import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/feedback_dialog.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

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
                const Center(child: CustomImage(path: KImages.passwordImage,height: 160,)),
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
                CustomFormWidget(
                  label: 'Confirm Password',
                  bottomSpace: 30.0,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'confirm password',
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
                PrimaryButton(
                    text: "Set New Password",
                    fontSize: 14,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                                            context,
                                          RouteNames.authenticationScreen,
                                  (route) => false);
                      // showDialog(
                      //     context: context,
                      //     barrierDismissible: false,
                      //     builder: (context) {
                      //       return FeedBackDialog(
                      //         height: 250.0,
                      //         image: KImages.checkIcon,
                      //         message: "Success",
                      //         child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             const Text(
                      //               'Your password is updated!',
                      //               textAlign: TextAlign.center,
                      //               style: TextStyle(
                      //                 color: Color(0xFF535769),
                      //                 fontSize: 14,
                      //                 fontFamily: 'Work Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.43,
                      //               ),
                      //             ),
                      //             Utils.verticalSpace(24),
                      //             PrimaryButton(
                      //                 text: "Back To Login",
                      //                 onPressed: () {
                      //                   Navigator.pushNamedAndRemoveUntil(
                      //                       context,
                      //                       RouteNames.authenticationScreen,
                      //                       (route) => false);
                      //                 })
                      //           ],
                      //         ),
                      //       );
                      //     });
                    }),
                Utils.verticalSpace(12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
