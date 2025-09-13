// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:foodigo/features/AllFood/cubit/all_food_state.dart';

class AllFoodSearchStateModel extends Equatable {
  final String search;
  final List<String> category;
  final String sort;
  final List<String> cuisine;
  final String minPrice;
  final String maxPrice;
  final String languageCode;
  int initialPage;
  bool isListEmpty;
  int currentIndex;
  final AllFoodState allFoodState;

  AllFoodSearchStateModel({
    required this.search,
    required this.category,
    required this.sort,
    required this.cuisine,
    required this.minPrice,
    required this.maxPrice,
    this.languageCode = '',
    this.initialPage = 1,
    this.currentIndex = 0,
    this.isListEmpty = false,
    this.allFoodState = const AllFoodInitial(),
  });

  AllFoodSearchStateModel copyWith({
    String? search,
    String? sort,
    List<String>? category,
    List<String>? cuisine,
    String? minPrice,
    String? maxPrice,
    String? languageCode,
    int? initialPage,
    int? currentIndex,
    bool? isListEmpty,
    AllFoodState? allFoodState,
  }) {
    return AllFoodSearchStateModel(
      search: search ?? this.search,
      category: category ?? this.category,
      sort: sort ?? this.sort,
      cuisine: cuisine ?? this.cuisine,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      languageCode: languageCode ?? this.languageCode,
      initialPage: initialPage ?? this.initialPage,
      currentIndex: currentIndex ?? this.currentIndex,
      isListEmpty: isListEmpty ?? this.isListEmpty,
      allFoodState: allFoodState ?? this.allFoodState,
    );
  }

  factory AllFoodSearchStateModel.init() => AllFoodSearchStateModel(
        search: '',
        sort: '',
        category: const [],
        cuisine: const [],
        minPrice: '',
        maxPrice: '',
        initialPage: 1,
        isListEmpty: false,
        allFoodState: const AllFoodInitial(),
      );

  factory AllFoodSearchStateModel.reset() => AllFoodSearchStateModel.init();

  @override
  List<Object?> get props => [
        search,
        category,
        sort,
        cuisine,
        minPrice,
        maxPrice,
        languageCode,
        initialPage,
        isListEmpty,
        currentIndex,
        allFoodState,
      ];
}
