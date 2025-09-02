// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:foodigo/features/HomeData/cubit/home_data_state.dart';

class SearchStateModel extends Equatable {
  final String search;
  final String sortBy;
  final List<String> category;
  final List<String> cuisine;
  final String minPrice;
  final String maxPrice;
  int initialPage;
  final HomeDataState homeDataState;

  SearchStateModel(
      {required this.search,
      required this.sortBy,
      required this.category,
      required this.cuisine,
      required this.minPrice,
      required this.maxPrice,
      this.initialPage = 1,
      this.homeDataState = const HomeDataInitial()});

  SearchStateModel copyWith({
    String? search,
    String? sortBy,
    List<String>? category,
    List<String>? cuisine,
    String? minPrice,
    String? maxPrice,
    int? initialPage,
    HomeDataState? homeDataState,
  }) {
    return SearchStateModel(
      search: search ?? this.search,
      sortBy: sortBy ?? this.sortBy,
      category: category ?? this.category,
      cuisine: cuisine ?? this.cuisine,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      initialPage: initialPage ?? this.initialPage,
      homeDataState: homeDataState ?? this.homeDataState,
    );
  }

  factory SearchStateModel.init() {
    return SearchStateModel(
      search: '',
      sortBy: '',
      category: [],
      cuisine: [],
      minPrice: '',
      maxPrice: '',
      initialPage: 1,
      homeDataState: const HomeDataInitial(),
    );
  }

  factory SearchStateModel.reset() {
    return SearchStateModel(
      search: '',
      sortBy: '',
      category: [],
      cuisine: [],
      minPrice: '',
      maxPrice: '',
      initialPage: 1,
      homeDataState: const HomeDataInitial(),
    );
  }

  @override
  List<Object?> get props => [
        search,
        sortBy,
        category,
        cuisine,
        minPrice,
        maxPrice,
        initialPage,
        homeDataState,
      ];
}
