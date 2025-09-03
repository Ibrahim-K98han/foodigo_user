import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/AllFood/cubit/all_food_state.dart';
import 'package:foodigo/features/AllFood/cubit/all_food_state_model.dart';
import 'package:foodigo/features/AllFood/model/all_food_model.dart';
import 'package:foodigo/features/AllFood/repository/all_food_repository.dart';
import 'package:foodigo/features/HomeData/category_model.dart';
import 'package:foodigo/features/HomeData/cuisines_model.dart';
import 'package:foodigo/features/HomeData/feature_product_model.dart';

import '../../Login/bloc/login_bloc.dart';
class AllFoodCubit extends Cubit<AllFoodState> {
  final AllFoodRepository _repository;
  final LoginBloc _loginBloc;

  AllFoodCubit({
    required AllFoodRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const AllFoodInitial());

  List<Foods> food = []; // all foods from API
  List<Foods> filteredFood = []; // filtered foods

  // filters
  String search = '';
  List<Categories> selectedCategories = [];
  List<Cuisines> selectedCuisines = [];
  String? minPrice;
  String? maxPrice;
  String sort = '';

  Future<void> getAllFood() async {
    emit(AllFoodLoading());
    final result = await _repository.getAllFood();
    result.fold(
          (l) => emit(AllFoodError(l.message, l.statusCode)),
          (success) {
        food = success;
        filteredFood = success;
        emit(AllFoodLoaded(filteredFood));
      },
    );
  }

  // 🔹 Filter methods
  void updateSearch(String text) {
    search = text;
  }

  void categories(List<Categories> cats) {
    selectedCategories = cats;
  }

  void cuisine(List<Cuisines> cuis) {
    selectedCuisines = cuis;
  }

  void minPriceFilter(String value) {
    minPrice = value;
  }

  void maxPriceFilter(String value) {
    maxPrice = value;
  }

  void updateSort(String s) {
    sort = s;
  }

  void clearFilters() {
    search = '';
    selectedCategories.clear();
    selectedCuisines.clear();
    minPrice = null;
    maxPrice = null;
    sort = '';
    filteredFood = food;
    emit(AllFoodLoaded(filteredFood));
  }

  void applyFilters() {
    List<Foods> result = List.from(food);

    // 🔹 search filter
    if (search.isNotEmpty) {
      result = result
          .where((f) =>
      f.name.toLowerCase().contains(search.toLowerCase()) ||
          (f.shortDescription ?? '')
              .toLowerCase()
              .contains(search.toLowerCase()))
          .toList();
    }

    // 🔹 category filter
    if (selectedCategories.isNotEmpty) {
      final ids = selectedCategories.map((c) => c.id.toString()).toList();
      result = result.where((f) => ids.contains(f.categoryId.toString())).toList();
    }

    // 🔹 cuisine filter
    if (selectedCuisines.isNotEmpty) {
      final ids = selectedCuisines.map((c) => c.id.toString()).toList();
      result = result.where((f) => ids.contains(f.restaurantId.toString())).toList();
    }

    // 🔹 price filter
    if (minPrice != null) {
      result = result.where((f) => int.parse(f.price) >= int.parse(minPrice!)).toList();
    }
    if (maxPrice != null) {
      result = result.where((f) => int.parse(f.price) <= int.parse(maxPrice!)).toList();
    }

    // 🔹 sort filter
    if (sort.isNotEmpty) {
      if (sort == 'Price Low-High') {
        result.sort((a, b) => int.parse(a.price).compareTo(int.parse(b.price)));
      } else if (sort == 'Price High-Low') {
        result.sort((a, b) => int.parse(b.price).compareTo(int.parse(a.price)));
      } else if (sort == 'Most Recent') {
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    }

    filteredFood = result;
    emit(AllFoodLoaded(filteredFood));
  }
}

