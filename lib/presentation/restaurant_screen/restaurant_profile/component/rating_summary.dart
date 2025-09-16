import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class RatingSummary extends StatelessWidget {
  const RatingSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomText(
                text: '4.9',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              Utils.horizontalSpace(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    initialRating: 3,
                    itemSize: 14,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const CustomText(
                    text: '5000+ ratings',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          _ratingBar(5, 0.5),
          _ratingBar(4, 0.2),
          _ratingBar(3, 0.14),
          _ratingBar(2, 0.06),
          _ratingBar(1, 0.1),
        ],
      ),
    );
  }
}

Widget _ratingBar(int star, double percent) {
  return Row(
    children: [
      CustomText(text: '$star'),
      // Text("$star", style: const TextStyle(fontWeight: FontWeight.bold)),
      const Icon(Icons.star, color: Colors.amber, size: 14),
      const SizedBox(width: 6),
      Expanded(
        child: LinearProgressIndicator(
          value: percent,
          backgroundColor: Colors.grey.shade200,
          color: Colors.amber,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      const SizedBox(width: 8),
      CustomText(text: "${(percent * 100).toInt()}%")
    ],
  );
}

