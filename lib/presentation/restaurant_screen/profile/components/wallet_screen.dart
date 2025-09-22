import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/EarningData/cubit/earning_cubit.dart';
import 'package:foodigo/features/restaurant_features/EarningData/cubit/earning_state.dart';
import 'package:foodigo/features/restaurant_features/EarningData/model/earning_model.dart';
import 'package:foodigo/presentation/restaurant_screen/profile/components/withdraw_amount_bottom_sheet.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/page_refresh.dart';
import 'package:intl/intl.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../../widget/fetch_error_text.dart';
import '../../../../widget/loading_widget.dart';
import '../../../../widget/title_and_navigator.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late EarningCubit earningCubit;

  @override
  void initState() {
    super.initState();
    earningCubit = context.read<EarningCubit>();
    earningCubit.getEarning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "My wallet"),
        body: PageRefresh(
          onRefresh: () async {
            earningCubit.getEarning();
          },
          child: BlocConsumer<EarningCubit, EarningState>(
            listener: (context, state) {
              final dashboard = state;
              if (dashboard is EarningStateError) {
                if (dashboard.statusCode == 503) {
                  FetchErrorText(text: dashboard.message);
                }
              }
            },
            builder: (context, state) {
              final earning = state;
              if (earning is EarningStateLoading) {
                return const LoadingWidget();
              } else if (earning is EarningStateError) {
                if (earning.statusCode == 503 ||
                    earningCubit.earningModel != null) {
                  return LoadWalletData(
                    earningModel: earningCubit.earningModel!,
                  );
                } else {
                  return FetchErrorText(text: earning.message);
                }
              } else if (earning is EarningStateLoaded) {
                return LoadWalletData(
                  earningModel: earningCubit.earningModel!,
                );
              }
              if (earningCubit.earningModel != null) {
                return LoadWalletData(
                  earningModel: earningCubit.earningModel!,
                );
              } else {
                return const FetchErrorText(text: 'Something Went Wrong');
              }
            },
          ),
        ));
  }
}

class LoadWalletData extends StatelessWidget {
  const LoadWalletData({super.key, required this.earningModel});

  final EarningModel earningModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: Utils.symmetric(h: 20),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "My Balance",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      CustomText(
                        text: Utils.formatPrice(
                            context, earningModel.totalIncome),
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
                            const CustomImage(
                              path: KImages.withdraw,
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
            ),
          ),
        ),
        Utils.verticalSpace(20.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TitleAndNavigator(
            title: 'Recent Transactions',
            // fontSize: 16,
            press: () {},
            seeAllColors: subTitleTextColor,
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: Utils.symmetric(h: 20.0),
              itemCount: earningModel.withdrawList!.length,
              itemBuilder: (context, int index) {
                final withdraw = earningModel.withdrawList![index];
                return ListTile(
                  title: CustomText(
                    text: withdraw.withdrawMethodName,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  subtitle: Row(
                    children: [
                      CustomText(
                        text: DateFormat('dd MMM yyyy, hh:mm a')
                            .format(DateTime.parse(withdraw.createdAt)),
                        fontSize: 12,
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 3),
                      //   child: Container(
                      //     width: 4.w,
                      //     height: 4.h,
                      //     decoration: const BoxDecoration(
                      //         color: smallContainerColor,
                      //         shape: BoxShape.circle),
                      //   ),
                      // ),
                      // const CustomText(
                      //   text: 'Aug 22, 2021',
                      //   fontSize: 12,
                      // ),
                    ],
                  ),
                  // leading: const CircleAvatar(
                  //   radius: 35,
                  //   backgroundColor: borderColor,
                  //   child: CustomImage(
                  //     path: KImages.message,
                  //     height: 35,
                  //   ),
                  // ),
                  trailing: CustomText(
                    text: Utils.formatPrice(context, withdraw.totalAmount),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
