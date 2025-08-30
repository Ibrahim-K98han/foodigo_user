import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';

class ImageSection extends StatefulWidget {
  final String image;

  ImageSection({super.key, required this.image});

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomImage(
          path: widget.image,
          fit: BoxFit.cover,
          height: 260,
          width: double.infinity,
        ),
        Positioned(
          top: 20,
          right: 14,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: whiteColor,
            ),
            child: Padding(
              padding: Utils.all(value: 6.0),
              child: const Center(
                  child: CustomImage(
                path: KImages.loveIcon,
                height: 20,
              )),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: Utils.all(value: 6.0),
                child: Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(6.r)),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
