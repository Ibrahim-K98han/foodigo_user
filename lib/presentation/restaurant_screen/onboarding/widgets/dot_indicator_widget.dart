import 'package:flutter/material.dart';

import '../../../../utils/constraints.dart';


class DotIndicatiorWidget extends StatelessWidget {
  const DotIndicatiorWidget({
    super.key,
    required this.currentIndex,
    required this.dotNumber,
  });

  final int currentIndex;
  final int dotNumber;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < dotNumber; i++) {
      list.add(_singleDot(i == currentIndex, context));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }

  Widget _singleDot(bool isActive, BuildContext context) {
    return AnimatedContainer(
      duration: kDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: isActive
            ? primaryColor
            : primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
