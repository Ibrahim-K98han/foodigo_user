import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  List<StepperData> stepperData = [
    StepperData(
      iconWidget: Container(
          width: 30.w,
          height: 30.h,
          padding: Utils.all(value: 2.0),
          decoration: const BoxDecoration(
            color: Color(0xff00CF7E),
            shape: BoxShape.circle,
          ),
          child: const CustomImage(
            path: KImages.delivery_package,
            fit: BoxFit.cover,
          )),
      title: StepperText('Order Placed'),
      subtitle: StepperText('12 July 2025, 04:25 PM'),
    ),
    StepperData(
      iconWidget: Container(
          width: 30.w,
          height: 30.h,
          padding: Utils.all(value: 2.0),
          decoration: const BoxDecoration(
            color: Color(0xff00CF7E),
            shape: BoxShape.circle,
          ),
          child: const CustomImage(
            path: KImages.scooter,
            fit: BoxFit.cover,
          )),
      title: StepperText('On it’s way!'),
      subtitle: StepperText('12 July 2025, 04:25 PM'),
    ),
    StepperData(
      iconWidget: Container(
          width: 30.w,
          height: 30.h,
          padding: Utils.all(value: 2.0),
          decoration: const BoxDecoration(
            color: Color(0xff00CF7E),
            shape: BoxShape.circle,
          ),
          child: const CustomImage(
            path: KImages.open_box,
            fit: BoxFit.cover,
          )),
      title: StepperText('Delivered'),
      subtitle: StepperText('12 July 2025, 04:25 PM'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with Banner
          SliverAppBar(
              pinned: true,
              expandedHeight: 215,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: Stack(
                fit: StackFit.loose,
                clipBehavior: Clip.none,
                children: [
                  const FlexibleSpaceBar(
                    background: CustomImage(
                      path: KImages.track_order_banner,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: -40.0,
                    left: 10.0,
                    right: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.05),
                            ),
                          ],
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Well done, You made it look easy',
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 4),
                            CustomText(
                              text: 'Your reward awaits you, champ.',
                              color: Color(0xff475569),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),

          // Timeline Steps
          const SliverToBoxAdapter(child: SizedBox(height: 60)),
          SliverToBoxAdapter(
            child: Padding(
              padding: Utils.symmetric(),
              child: AnotherStepper(
                  verticalGap: 25,
                  iconHeight: 24,
                  iconWidth: 24,
                  inActiveBarColor: const Color(0xff00CF7E),
                  barThickness: 4,
                  stepperList: stepperData,
                  stepperDirection: Axis.vertical),
            ),
          ),

          // Order Summary
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Padding(
              padding: Utils.symmetric(),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Order ID: 1646753416'),
                  SizedBox(height: 8),
                  CustomText(text: 'Billing Address: Gandhinagar, Gujarat'),
                  SizedBox(height: 8),
                  CustomText(text: 'Type: Home'),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: CustomImage(
                            path: KImages.rImage1,
                            height: 26,
                            width: 40,
                            fit: BoxFit.cover),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                          child:
                              CustomText(text: 'Chicken skewers with Slices')),
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildTimelineStep({
    required String icon,
    required Color color,
    required String title,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: Utils.all(value: 4.0),
                decoration: const BoxDecoration(
                  color: Color(0xff00CF7E),
                  shape: BoxShape.circle,
                ),
                child: CustomImage(
                  path: icon,
                  color: color,
                  height: 16,
                  width: 16,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 4,
                height: 40,
                color: const Color(0xff00CF7E),
              )
            ],
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: time,
                fontSize: 11,
              )
            ],
          ),
        ],
      ),
    );
  }
}
