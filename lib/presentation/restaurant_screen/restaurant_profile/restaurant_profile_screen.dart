import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../../utils/constraints.dart';
import 'component/dialog_header.dart';
import 'component/rating_summary.dart';
import 'component/restaurant_header.dart';
import 'component/restaurant_tab_content.dart';
import 'component/review_card.dart';

class RestaurantProfileScreen extends StatelessWidget {
  const RestaurantProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ///============= Restaurant Profile Header ===============///
          RestaurantHeader(
            onTap: () => _showReviewDialog(context),
          ),

          /// ============= Restaurant Tab Container ==============
          const Expanded(child: RestaurantTabContents()),
        ],
      ),
    );
  }
}

void _showReviewDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        child: SizedBox(
          width: 400,
          height: 600,
          child: Column(
            children: [
              const DialogHeader(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      RatingSummary(),
                      const SizedBox(height: 16),
                      _filterChips(),
                      const SizedBox(height: 16),
                      ...List.generate(3, (_) => const ReviewCard()),
                      const SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const CustomText(
                            text: 'See more',
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _filterChips() {
  return Row(
    children: [
      _filterButton("Newest", selected: true),
      const SizedBox(width: 8),
      _filterButton("Highest Rating"),
    ],
  );
}

Widget _filterButton(String text, {bool selected = false}) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: selected ? Colors.amber : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(text: text));
}
