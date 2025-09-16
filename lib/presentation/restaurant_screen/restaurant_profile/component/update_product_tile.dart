import 'package:flutter/material.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class UpdateProductTile extends StatelessWidget {
  const UpdateProductTile({super.key, this.title, this.widget});

  final String? title;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: borderColor),
        borderRadius: Utils.borderRadius(),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          iconColor: blackColor,
          title: CustomText(
            text: title ?? '',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          children: [
            Padding(padding: Utils.symmetric(v: 10.0), child: widget),
          ],
        ),
      ),
    );
  }
}