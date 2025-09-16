import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/primary_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Change Password",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 24),
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //   image: AssetImage(KImages.bg),
            // )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Utils.verticalSpace(24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "Old Password",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Utils.verticalSpace(10),
                  const TextField(
                    decoration: InputDecoration(hintText: "Old Password"),
                  ),
                  Utils.verticalSpace(10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "New Password",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Utils.verticalSpace(10),
                  const TextField(
                    decoration: InputDecoration(hintText: "New Password"),
                  ),
                  Utils.verticalSpace(16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "Confirm Password",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Utils.verticalSpace(10),
                  const TextField(
                    decoration: InputDecoration(hintText: "Confirm Password"),
                  ),
                  Utils.verticalSpace(24),
                  PrimaryButton(
                      text: "Change Passowrd",
                      fontSize: 14,
                      onPressed: () {
                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return FeedBackDialog(
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
                        //                 text: "dismiss",
                        //                 onPressed: () {
                        //                   Navigator.pop(context);
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
      ),
    );
  }
}
