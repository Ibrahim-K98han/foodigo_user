import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/presentation/screen/home/components/category_list.dart';
import 'package:foodigo/widget/custom_appbar.dart';

import '../../../features/AllFood/cubit/all_food_cubit.dart';
import '../../../features/HomeData/cubit/home_data_cubit.dart';
import '../../../utils/utils.dart';
import '../../core/routes/route_names.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  int selectedIndex = 0;
  late AllFoodCubit allFoodCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allFoodCubit = context.read<AllFoodCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeDataCubit>();
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
              crossAxisSpacing: 10.0,
              childAspectRatio: 2.1,
            ),
            itemCount: homeCubit.homeModel!.categories!.length,
            itemBuilder: (BuildContext context, index) {
              final category = homeCubit.homeModel!.categories![index];
              final categories = homeCubit.homeModel!.categories!;
              return CategoryCard(
                categories: category,
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  allFoodCubit.clearFilters();
                  allFoodCubit.categories([categories[index].id.toString()]);
                  Navigator.pushNamed(
                    context,
                    RouteNames.allFoodScreen,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
