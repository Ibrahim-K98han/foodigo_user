import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_cubit.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_state.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/model/restaurant_profile_model.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/model/restaurant_profile_state_model.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/loading_widget.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/primary_button.dart';
import 'component/account_info.dart';
import 'component/other_info.dart';
import 'component/photo_attach.dart';
import 'component/restaurant_info.dart';
import 'component/restaurant_owner_info.dart';

class EditRestaurantScreen extends StatefulWidget {
  const EditRestaurantScreen({super.key});

  @override
  State<EditRestaurantScreen> createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<EditRestaurantScreen> {
  late RestaurantProfileCubit resProCubit;

  @override
  void initState() {
    super.initState();
    resProCubit = context.read<RestaurantProfileCubit>();
    resProCubit.getRestaurantProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Restaurant'),
      body: BlocConsumer<RestaurantProfileCubit, RestaurantProfileStateModel>(
        listener: (context, state) {
          final profile = state.restaurantProfileState;
          if (profile is UpdateRestaurantProfileLoaded) {
            Utils.successSnackBar(context, profile.message);
          }
          // }else if(profile is UpdateRestaurantProfileLoaded){
          //   Utils.successSnackBar(context, profile.message);
          // }
        },
        builder: (context, state) {
          final profile = state.restaurantProfileState;
          if (profile is UpdateRestaurantProfileLoading) {
            return const LoadingWidget();
          } else if (profile is UpdateRestaurantProfileError) {
            if (profile.statusCode == 503 ||
                resProCubit.restaurantProfileModel != null) {
              return ProfileDataLoad(
                restaurantProfileModel: resProCubit.restaurantProfileModel!,
              );
            } else {
              return FetchErrorText(text: profile.message);
            }
          } else if (profile is UpdateRestaurantProfileLoaded) {
            return ProfileDataLoad(
              restaurantProfileModel: resProCubit.restaurantProfileModel!,
            );
          }
          if (resProCubit.restaurantProfileModel != null) {
            return ProfileDataLoad(
              restaurantProfileModel: resProCubit.restaurantProfileModel!,
            );
          } else {
            return const FetchErrorText(text: 'Something Went Wrong');
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: PrimaryButton(
          text: 'Update',
          onPressed: () {
            resProCubit.updateRestaurantProfile();
          },
        ),
      ),
    );
  }
}

class ProfileDataLoad extends StatelessWidget {
  const ProfileDataLoad({super.key, required this.restaurantProfileModel});

  final RestaurantProfileModel restaurantProfileModel;

  @override
  Widget build(BuildContext context) {
    final resProCubit = context.read<RestaurantProfileCubit>();
    return Padding(
      padding: Utils.symmetric(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///============ Attach Photo =============///
            const PhotoAttach(),
            Utils.verticalSpace(12),

            ///============ Restaurant Info ==========///
            const RestaurantInfo(),
            Utils.verticalSpace(12),

            ///============ Restaurant Owner Info ==========///
            const RestaurantOwnerInfo(),
            Utils.verticalSpace(12),

            ///============ Account Info ==========///
            const AccountInfo(),
            Utils.verticalSpace(12),

            ///============ Other Info ==========///
            const OtherInfo(),
            Utils.verticalSpace(12),

            BlocBuilder<RestaurantProfileCubit, RestaurantProfileStateModel>(
              builder: (context, state) {
                return SwitchWidget(
                  text: 'Make Featured',
                  initialValue: state.isFeatured,
                  onToggle: (bool value) {
                    resProCubit.isFeatured(value);
                  },
                );
              },
            ),

            BlocBuilder<RestaurantProfileCubit, RestaurantProfileStateModel>(
              builder: (context, state) {
                return SwitchWidget(
                  text: 'Pickup Order',
                  initialValue: state.isPickupOrder,
                  onToggle: (bool value) {
                    resProCubit.isPickup(value);
                  },
                );
              },
            ),

            BlocBuilder<RestaurantProfileCubit, RestaurantProfileStateModel>(
              builder: (context, state) {
                return SwitchWidget(
                  text: 'Delivery Order',
                  initialValue: state.isDeliveryOrder,
                  onToggle: (bool value) {
                    resProCubit.isDelivery(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    super.key,
    this.text,
    required this.initialValue,
    required this.onToggle,
    this.widget,
    this.icon,
  });

  final String? text;
  final String? icon;
  final bool initialValue;
  final ValueChanged<bool> onToggle;
  final Widget? widget;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
  }

  void _toggle() {
    setState(() => isOn = !isOn);
    widget.onToggle(isOn);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // white shadow with opacity
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // horizontal, vertical offset
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // CustomImage(
                //   path: widget.icon,
                //   width: 24,
                //   height: 24,
                //   fit: BoxFit.cover,
                // ),
                Utils.horizontalSpace(12),
                CustomText(
                  text: widget.text ?? '',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Row(
              children: [
                const CustomText(text: '', fontWeight: FontWeight.w500),
                Utils.horizontalSpace(8),
                GestureDetector(
                  onTap: _toggle,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: 50,
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: isOn ? textColor : Colors.grey.shade100,
                    ),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 100),
                      alignment:
                          isOn ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
