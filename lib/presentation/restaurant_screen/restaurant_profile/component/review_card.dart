import 'package:flutter/material.dart';

import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                child: CustomImage(path: KImages.profile),
              ),
              SizedBox(width: 8),
              CustomText(
                text: 'Brain Loon',
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Row(
                  children: List.generate(
                      5,
                          (_) => const Icon(Icons.star,
                          color: Colors.amber, size: 18))),
              Utils.horizontalSpace(4),
              const CustomText(
                text: '2 days ago',
                color: Color(0xff64748B),
              )
            ],
          ),
          const SizedBox(height: 6),
          const CustomText(
            text: "“Wow tasty, really enjoy it”",
          ),
          const SizedBox(height: 6),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              CustomText(
                text: 'Helpful',
                color: Color(0xff64748B),
              ),
            ],
          )
        ],
      ),
    );
  }
}