import 'package:flutter/material.dart';

import '../../../../utils/k_images.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class DialogHeader extends StatelessWidget {
  const DialogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        children: [
          Row(
            children: [
              const CustomText(
                text: 'Reviews',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              const Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: const Row(
              children: [
                CustomImage(
                  path: KImages.rProfile,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 8),
                CustomText(
                  text: 'Chef’s Place',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                Spacer(),
                Icon(Icons.location_on_outlined, color: Colors.grey, size: 18),
                CustomText(
                  text: 'San Jose, Spain',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF475569),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
