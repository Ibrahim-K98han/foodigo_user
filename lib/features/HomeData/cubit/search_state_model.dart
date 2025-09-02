// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:foodigo/features/HomeData/category_model.dart';
import 'package:foodigo/features/HomeData/cubit/home_data_state.dart';
import 'package:foodigo/features/HomeData/cuisines_model.dart';

import '../feature_product_model.dart';


class SearchStateModel {
  final String search;
  final List<Categories> category;
  final List<Cuisines> cuisine;
  final String minPrice;
  final String maxPrice;
  final List<FeaturedProducts> filteredProducts;
  final HomeDataState homeDataState;

  SearchStateModel({
    required this.search,
    required this.category,
    required this.cuisine,
    required this.minPrice,
    required this.maxPrice,
    required this.filteredProducts,
    required this.homeDataState,
  });

  factory SearchStateModel.init() => SearchStateModel(
    search: '',
    category: [],
    cuisine: [],
    minPrice: '',
    maxPrice: '',
    filteredProducts: [],
    homeDataState: HomeDataInitial(),
  );

  SearchStateModel copyWith({
    String? search,
    List<Categories>? category,
    List<Cuisines>? cuisine,
    String? minPrice,
    String? maxPrice,
    List<FeaturedProducts>? filteredProducts,
    HomeDataState? homeDataState,
  }) {
    return SearchStateModel(
      search: search ?? this.search,
      category: category ?? this.category,
      cuisine: cuisine ?? this.cuisine,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      homeDataState: homeDataState ?? this.homeDataState,
    );
  }

  factory SearchStateModel.reset() => SearchStateModel.init();
}
