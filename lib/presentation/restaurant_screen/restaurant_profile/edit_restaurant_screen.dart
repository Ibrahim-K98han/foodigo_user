import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_cubit.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_state.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/model/restaurant_profile_model.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/page_refresh.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/primary_button.dart';
import 'component/open_schedule.dart';
import 'component/photo_attach.dart';
import 'component/restaurant_info.dart';

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
      body: PageRefresh(
        onRefresh: () async {
          resProCubit.getRestaurantProfile();
        },
        child: BlocConsumer<RestaurantProfileCubit, RestaurantProfileState>(
          listener: (context, state) {
            final profile = state;
            if (profile is RestaurantProfileError) {
              if (profile.statusCode == 503) {
                FetchErrorText(text: profile.message);
              }
            }
          },
          builder: (context, state) {
            final profile = state;
            if (profile is RestaurantProfileLoading) {
              return const LoadingWidget();
            } else if (profile is RestaurantProfileError) {
              if (profile.statusCode == 503 ||
                  resProCubit.restaurantProfileModel != null) {
                return ProfileDataLoad(
                  restaurantProfileModel: resProCubit.restaurantProfileModel!,
                );
              } else {
                return FetchErrorText(text: profile.message);
              }
            } else if (profile is RestaurantProfileLoaded) {
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
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: PrimaryButton(text: 'Update', onPressed: () {}),
      ),
    );
  }
}

class ProfileDataLoad extends StatelessWidget {
  const ProfileDataLoad({super.key, required this.restaurantProfileModel});

  final RestaurantProfileModel restaurantProfileModel;

  @override
  Widget build(BuildContext context) {
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

            ///============== Open Schedule ==========///
            const OpenSchedule(),
            Utils.verticalSpace(16),
            SwitchWidget(
              text: 'Delivery',
              icon: KImages.delivery_man,
              initialValue: true,
              onToggle: (bool value) {
                if (value == true) {
                  restaurantProfileModel.restaurantProfile!.isFeatured;
                }
              },
            ),
            SwitchWidget(
              text: 'Dining',
              icon: KImages.delivery_man,
              initialValue: true,
              onToggle: (bool value) {
                if (value == true) {
                  restaurantProfileModel.restaurantProfile!.isPickupOrder;
                }
              },
            ),
            SwitchWidget(
              text: 'Take Away',
              icon: KImages.delivery_man,
              initialValue: true,
              onToggle: (bool value) {
                if (value == true) {
                  restaurantProfileModel.restaurantProfile!.isDeliveryOrder;
                }
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
                CustomImage(
                  path: widget.icon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
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
                const CustomText(
                  text: '',
                  fontWeight: FontWeight.w500,
                ),
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
