import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/Privacy/cubit/privacy_policy_cubit.dart';
import 'package:foodigo/features/Privacy/cubit/privacy_policy_state.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/loading_widget.dart';

class OfferAndRewardScreen extends StatefulWidget {
  const OfferAndRewardScreen({super.key});

  @override
  State<OfferAndRewardScreen> createState() => _OfferAndRewardScreenState();
}

class _OfferAndRewardScreenState extends State<OfferAndRewardScreen> {
  late PrivacyPolicyCubit ppCubit;
  @override
  void initState() {
    super.initState();
    ppCubit = context.read<PrivacyPolicyCubit>();
    ppCubit.fetchOfferAndReward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Offer And Reward'),
      body: BlocConsumer<PrivacyPolicyCubit, PrivacyPolicyState>(
        listener: (context, state) {
          if (state is OfferAndRewardError) {
            Utils.errorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is OfferAndRewardLoading) {
            return const LoadingWidget();
          } else if (state is OfferAndRewardLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: CustomText(
                    text: 'Offer Banner',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ppCubit.offerAndReward!.banners!.length,
                    itemBuilder: (context, index) {
                      final offer = ppCubit.offerAndReward!.banners![index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          clipBehavior: Clip.hardEdge,
                          child: CustomImage(
                            path: RemoteUrls.imageUrl(offer.image),
                            width: 250.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
