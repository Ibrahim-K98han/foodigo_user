import 'package:flutter/cupertino.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';


class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: Utils.symmetric(),
          child: const Row(
            children: [
              CustomText(
                text: "Order Status",
                color: blackColor,
                fontSize: 22.0,
                fontFamily: bold700,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        Utils.verticalSpace(16),
        Expanded(
          child: GridView.builder(gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              crossAxisCount: 2,),
              itemCount: 4,
              itemBuilder: (context, index){
            return StatusCard();
          }),
        )
      ],
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 157,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Padding(
        padding: Utils.symmetric(h: 6.0),
        child: const Row(
          children: [
            CustomText(
              text: 'Berger',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
