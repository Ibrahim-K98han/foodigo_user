import 'package:flutter/material.dart';
import 'package:foodigo/presentation/screen/home/components/category_list.dart';
import 'package:foodigo/widget/custom_appbar.dart';

import '../../../utils/utils.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'All Categories'),
      body: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 40,
              offset: Offset(0, 2),
              spreadRadius: 10,
            )
          ],
        ),
        child: Padding(
          padding: Utils.symmetric(),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: 2.1),
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                return CategoryCard(
                  onTap: () {},
                  isSelected: true,
                );
              }),
        ),
      ),
    );
  }
}
