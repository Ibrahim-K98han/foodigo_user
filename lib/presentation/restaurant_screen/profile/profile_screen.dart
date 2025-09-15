import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/Login/bloc/restaurant_login_event.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/loading_widget.dart';
import '../../../features/restaurant_features/Login/bloc/restaurant_login_state.dart';
import '../../../features/restaurant_features/Login/bloc/restaurant_login_bloc.dart';
import '../../../features/restaurant_features/Login/model/restaurant_login_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/feedback_dialog.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';
import 'components/drawer_item.dart';
import 'components/profile_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile"),
      body: CustomScrollView(
        slivers: [
          const ProfileImage(),
          SliverList(
              delegate: SliverChildListDelegate([
            DrawerItem(
              title: "Restaurant Info",
              icon: KImages.profileInActive,
              onTap: () {
                Navigator.pushNamed(
                    context, RouteNames.restaurantProfileScreen);
              },
            ),
            DrawerItem(
              title: "Wallet",
              icon: KImages.dollarBag,
              onTap: () {
                // Navigator.pushNamed(context, RouteNames.walletScreen);
              },
            ),
            DrawerItem(
                title: "Settings",
                icon: KImages.settingIcon,
                onTap: () {
                  // Navigator.pushNamed(context, RouteNames.settingsScreen);
                }),
            DrawerItem(
                title: "Change Password", icon: KImages.unlock, onTap: () {}),

            Utils.verticalSpace(40.0),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const LogoutPrompt());
              },
              child: Padding(
                padding: Utils.symmetric(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: const Color(0xFFF01543).withOpacity(0.4),
                    ),
                  ),
                  child: Padding(
                    padding: Utils.symmetric(h: 20.0, v: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomImage(path: KImages.logout),
                        Utils.horizontalSpace(8.0),
                        const CustomText(
                          text: "Logout",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: redColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ])),
        ],
      ),
    );
  }
}

class LogoutPrompt extends StatelessWidget {
  const LogoutPrompt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final restaurantBloc = context.read<RestaurantLoginBloc>();
    final email = restaurantBloc.userInformation!.restaurant!.email;
    print(email);
    return FeedBackDialog(
        image: KImages.logoutImage,
        //   height: 280.0,
        message: "Do you want to\nLOGOUT",
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: 'Cancel',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    borderRadiusSize: 4.0,
                    isGradient: false,
                    bgColor: blackColor,
                    textColor: whiteColor,
                    fontSize: 16.0,
                    minimumSize: Size(Utils.hSize(150.0), Utils.vSize(30.0)),
                    maximumSize: Size(Utils.hSize(150.0), Utils.vSize(30.0)),
                  ),
                ),
                Utils.horizontalSpace(20),
                Expanded(
                  child: BlocConsumer<RestaurantLoginBloc,
                      RestaurantLoginStateModel>(
                    listener: (context, state) {
                      if (state.restaurantLoginState
                          is RestaurantLoginStateLogoutLoaded) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          RouteNames.authenticationScreen,
                          (route) => false,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state.restaurantLoginState
                          is RestaurantLoginStateLogoutLoading) {
                        return Center(
                          child: SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: const LoadingWidget(),
                          ),
                        );
                      }
                      return PrimaryButton(
                        text: 'Logout',
                        onPressed: () {
                          context
                              .read<RestaurantLoginBloc>()
                              .add( RestaurantLoginEventLogout(

                            email: email
                          ));
                        },
                        bgColor: redColor,
                        textColor: whiteColor,
                        borderRadiusSize: 4.0,
                        fontSize: 16.0,
                        minimumSize:
                            Size(Utils.hSize(150.0), Utils.vSize(30.0)),
                        maximumSize:
                            Size(Utils.hSize(150.0), Utils.vSize(30.0)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    super.key,
    this.text,
    required this.initialValue,
    required this.onToggle,
    this.widget,
  });

  final String? text;
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
      padding: Utils.only(left: 24),
      child: Row(
        children: [
          const CustomText(
            text: 'Switch to Seller',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          Utils.horizontalSpace(12),
          GestureDetector(
            onTap: _toggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 50,
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // color: isOn ? textColor : Colors.grey.shade400,
                  border: Border.all(
                      color: isOn ? redColor : Colors.grey.shade400, width: 2)),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 100),
                alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Colors.red,
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
    );
  }
}
