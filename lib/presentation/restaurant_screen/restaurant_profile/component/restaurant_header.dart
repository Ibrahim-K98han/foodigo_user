import 'package:flutter/material.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../core/routes/route_names.dart';

class RestaurantHeader extends StatefulWidget {
  const RestaurantHeader({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  State<RestaurantHeader> createState() => _RestaurantHeaderState();
}

class _RestaurantHeaderState extends State<RestaurantHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const CustomImage(
              path: KImages.banner,
              fit: BoxFit.cover,
              height: 160,
              width: double.infinity,
            ),
            Positioned(
              top: 45,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_sharp,
                  size: 30,
                  color: whiteColor,
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: const CustomImage(
                      path: KImages.rProfile,
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: Utils.only(top: 40.0, bottom: 6.0, right: 10.0, left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: 'Kombucha',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  Utils.horizontalSpace(4.0),
                  GestureDetector(
                    // onTap: () => Navigator.pushNamed(
                    //     context, RouteNames.editRestaurantScreen),
                    child: const CustomImage(
                      path: KImages.editIcon,
                      color: greenColor,
                      width: 18,
                      height: 18,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const CustomImage(path: KImages.location, height: 20),
                      Utils.horizontalSpace(6.0),
                      const CustomText(
                        text: 'QS Jose,Spain',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  Utils.horizontalSpace(10.0),
                  Container(
                    height: 5,
                    width: 5,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF98C3B), shape: BoxShape.circle),
                  ),
                  Utils.horizontalSpace(10.0),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Row(
                      children: [
                        const CustomImage(path: KImages.star),
                        Utils.horizontalSpace(6.0),
                        const CustomText(
                          text: '4.9 (5k+)',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Utils.verticalSpace(10.0),
            ],
          ),
        ),
      ],
    );
  }
}
