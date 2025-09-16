import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/presentation/restaurant_screen/profile/components/withdraw_amount_bottom_sheet.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../../widget/title_and_navigator.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "My wallet"),
      body: Column(
        children: [
          Padding(
            padding: Utils.symmetric(),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5EDED),
                  borderRadius: Utils.borderRadius(),
                  border: Border.all(
                    color: borderColor,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 40,
                      offset: Offset(0, 2),
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: Padding(
                  padding: Utils.symmetric(v: 30.0),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "My Balance",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          CustomText(
                            text: "\$2536.00",
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            backgroundColor: whiteColor,
                            constraints: BoxConstraints.loose(
                              Size(
                                Utils.mediaQuery(context).width,
                                Utils.mediaQuery(context).height * 0.9,
                              ),
                            ),
                            isScrollControlled: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Utils.radius(32.0)),
                                topRight: Radius.circular(Utils.radius(32.0)),
                              ),
                            ),
                            builder: (context) => DraggableScrollableSheet(
                              initialChildSize: 0.85,
                              minChildSize: 0.5,
                              maxChildSize: 0.95,
                              expand: false,
                              builder: (context, scrollController) {
                                return SingleChildScrollView(
                                  controller: scrollController,
                                  child: const WithdrawAmountBottomSheet(),
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: primaryColor),
                          child: Padding(
                            padding: Utils.symmetric(h: 10.0, v: 10.0),
                            child: Row(
                              children: [
                                 CustomImage(
                                  path: KImages.message,
                                  height: 24,
                                ),
                                Utils.horizontalSpace(6.0),
                                const CustomText(
                                  text: 'Withdraw',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                )),
          ),
          Utils.verticalSpace(20.0),
          TitleAndNavigator(
            title: 'Recent Transactions',
            // fontSize: 16,
            press: () {},
            seeAllColors: subTitleTextColor,
          ),
          Utils.verticalSpace(16),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, int index) {
                  return ListTile(
                    title: const CustomText(
                      text: "Withdraw",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    subtitle: Row(
                      children: [
                        const CustomText(
                          text: '03:20 PM',
                          fontSize: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Container(
                            width: 4.w,
                            height: 4.h,
                            decoration: const BoxDecoration(
                                color: smallContainerColor,
                                shape: BoxShape.circle),
                          ),
                        ),
                        const CustomText(
                          text: 'Aug 22, 2021',
                          fontSize: 12,
                        ),
                      ],
                    ),
                    leading: const CircleAvatar(
                      radius: 35,
                      backgroundColor: borderColor,
                      child: CustomImage(
                        path: KImages.message,
                        height: 35,
                      ),
                    ),
                    trailing: const CustomText(text: "-\$1200.00"),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
