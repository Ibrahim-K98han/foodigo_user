import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../../data/remote_url.dart';
import '../../../../features/HomeData/category_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/title_and_navigator.dart';
import '../../../core/routes/route_names.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.categories});

  final List<Categories> categories;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndNavigator(
          title: 'Categories',
          press: () {
            Navigator.pushNamed(context, RouteNames.allCategoryScreen);
          },
        ),
        // Utils.verticalSpace(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              ...List.generate(widget.categories.length, (index) {
                // final service = DummyData.influencerList[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CategoryCard(
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      Navigator.pushNamed(
                        context,
                        RouteNames.allFoodScreen,
                        arguments: widget.categories[index],
                      );
                    },
                    categories: widget.categories[index],
                  ),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.categories,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final Categories categories;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      onTap: onTap,
      child: Container(
          padding: Utils.symmetric(h: 12.0, v: 10.0),
          decoration: BoxDecoration(
            color: whiteColor, // always white background
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(
                path: RemoteUrls.imageUrl(categories.icon),
                height: 20,
                width: 20,
                fit: BoxFit.cover,
              ),
              Utils.horizontalSpace(4.0),
              Flexible(
                child: CustomText(
                  text: categories.name,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  maxLine: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
    );
  }
}
