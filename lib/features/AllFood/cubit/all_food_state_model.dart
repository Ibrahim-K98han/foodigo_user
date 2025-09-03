// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:foodigo/features/AllFood/cubit/all_food_state.dart';
import 'package:foodigo/features/HomeData/category_model.dart';
import 'package:foodigo/features/HomeData/cubit/home_data_state.dart';
import 'package:foodigo/features/HomeData/cuisines_model.dart';

class AllFoodSearchStateModel {
  final String search;
  final List<Categories> category;
  final List<Cuisines> cuisine;
  final String minPrice;
  final String maxPrice;
  final AllFoodState allFoodState;

  AllFoodSearchStateModel({
    required this.search,
    required this.category,
    required this.cuisine,
    required this.minPrice,
    required this.maxPrice,
    required this.allFoodState,
  });

  factory AllFoodSearchStateModel.init() => AllFoodSearchStateModel(
        search: '',
        category: [],
        cuisine: [],
        minPrice: '',
        maxPrice: '',
        allFoodState: const AllFoodInitial(),
      );

  AllFoodSearchStateModel copyWith({
    String? search,
    List<Categories>? category,
    List<Cuisines>? cuisine,
    String? minPrice,
    String? maxPrice,
    AllFoodState? allFoodState,
  }) {
    return AllFoodSearchStateModel(
      search: search ?? this.search,
      category: category ?? this.category,
      cuisine: cuisine ?? this.cuisine,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      allFoodState: allFoodState ?? this.allFoodState,
    );
  }

  factory AllFoodSearchStateModel.reset() => AllFoodSearchStateModel.init();
}
