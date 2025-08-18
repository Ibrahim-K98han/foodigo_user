import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class SelectAddonSection extends StatefulWidget {
  const SelectAddonSection({super.key});

  @override
  State<SelectAddonSection> createState() => _SelectAddonSectionState();
}

class _SelectAddonSectionState extends State<SelectAddonSection> {
  bool dSmall = false;
  bool dMedium = false;
  bool dLarge = false;
  bool dExtraLarge = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
              title: Row(
                children: [
                  const CustomText(
                    text: "Select Addon",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      padding: Utils.symmetric(h: 10.0, v: 4.0),
                      decoration: BoxDecoration(
                        color: redColor.withOpacity(0.1),
                        border: Border.all(color: redColor),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: const CustomText(
                        text: 'Optional',
                        color: redColor,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
              children: [
                Padding(
                  padding: Utils.symmetric(h: 10.0),
                  child: Column(
                    children: [
                      SelectAddonWidget(
                        size: 'Small',
                        isChecked: dSmall,
                        onTap: (value) {
                          setState(() {
                            dSmall = value!;
                          });
                        },
                      ),
                      Utils.verticalSpace(10.0),
                      SelectAddonWidget(
                        size: 'Medium',
                        isChecked: dMedium,
                        onTap: (value) {
                          setState(() {
                            dMedium = value!;
                          });
                        },
                      ),
                      Utils.verticalSpace(10.0),
                      SelectAddonWidget(
                        size: 'Large',
                        isChecked: dLarge,
                        onTap: (value) {
                          setState(() {
                            dLarge = value!;
                          });
                        },
                      ),
                      Utils.verticalSpace(10.0),
                      SelectAddonWidget(
                        size: 'Extra Large',
                        isChecked: dExtraLarge,
                        onTap: (value) {
                          setState(() {
                            dExtraLarge = value!;
                          });
                        },
                      ),
                      Utils.verticalSpace(10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Utils.verticalSpace(20.0),
      ],
    );
  }
}

class SelectAddonWidget extends StatefulWidget {
  const SelectAddonWidget({super.key, this.isChecked, this.onTap, this.size});

  final String? size;
  final bool? isChecked;
  final ValueChanged<bool?>? onTap;

  @override
  State<SelectAddonWidget> createState() => _SelectAddonWidgetState();
}

class _SelectAddonWidgetState extends State<SelectAddonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                checkColor: blackColor,
                activeColor: primaryColor,
                side: const BorderSide(
                  color: primaryColor,
                  width: 2.0,
                ),
                value: widget.isChecked,
                onChanged: widget.onTap,
              ),
              CustomText(
                text: widget.size ?? '',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Padding(
            padding: Utils.symmetric(h: 10.0),
            child: Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    shape: BoxShape.rectangle,
                    color: primaryColor.withOpacity(0.3),
                  ),
                  child: const Center(
                    child: Icon(Icons.remove),
                  ),
                ),
                Utils.horizontalSpace(8.0),
                const CustomText(
                  text: '1',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                Utils.horizontalSpace(8.0),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    shape: BoxShape.rectangle,
                    color: primaryColor,
                  ),
                  child: const Center(
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
