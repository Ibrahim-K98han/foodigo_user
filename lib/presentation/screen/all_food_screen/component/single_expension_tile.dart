import 'package:flutter/material.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class SingleExpansionTile extends StatelessWidget {
  const SingleExpansionTile({
    super.key,
    this.isExpand,
    this.heading,
    this.padding,
    this.headingColor,
    this.borColor,
    required this.child,
  });

  final bool? isExpand;
  final String? heading;
  final List<Widget> child;
  final EdgeInsets ? padding;
  final Color ? headingColor;
  final Color ? borColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding?? Utils.only(bottom: 16.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: borColor ?? borderColor))
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            dividerColor: transparent,
            shadowColor: transparent,
            splashColor: transparent,
            splashFactory: NoSplash.splashFactory),
        child: ExpansionTile(
            tilePadding: Utils.all(),
            childrenPadding: Utils.all(),
            initiallyExpanded: isExpand??false,
            title: CustomText(
              text: heading??'',
              color: headingColor ?? blackColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            children: child
        ),
      ),
    );
  }
}
