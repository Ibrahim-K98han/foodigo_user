import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/primary_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: 'Password Change', visibleLeading: true),
      backgroundColor: scaffoldBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: Utils.symmetric(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Utils.verticalSpace(20.0),
              Center(
                child: CustomImage(
                  path: KImages.passwordImage,
                  width: 170.w,
                  height: 160.h,
                  fit: BoxFit.cover,
                ),
              ),
              Utils.verticalSpace(40.0),
              CustomFormWidget(
                label: 'Current Password',
                bottomSpace: 14.0,
                child: TextFormField(
                  decoration: InputDecoration(
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
                    hintText: 'Current password',
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
              Utils.verticalSpace(10),
              CustomFormWidget(
                label: 'New Password',
                bottomSpace: 14.0,
                child: TextFormField(
                  decoration: InputDecoration(
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
                    hintText: 'New password',
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
              Utils.verticalSpace(10),
              CustomFormWidget(
                label: 'Confirm Password',
                bottomSpace: 14.0,
                child: TextFormField(
                  decoration: InputDecoration(
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
                    hintText: 'Confirm password',
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
              Utils.verticalSpace(40),
              PrimaryButton(text: 'Save', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
