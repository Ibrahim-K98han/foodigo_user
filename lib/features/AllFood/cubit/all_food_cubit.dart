import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/AllFood/cubit/all_food_state.dart';
import 'package:foodigo/features/AllFood/model/all_food_model.dart';
import 'package:foodigo/features/AllFood/repository/all_food_repository.dart';
import 'package:foodigo/utils/utils.dart';
import '../../Login/bloc/login_bloc.dart';
import 'all_food_state_model.dart';

class AllFoodCubit extends Cubit<AllFoodSearchStateModel> {
  final AllFoodRepository _repository;
  final LoginBloc _loginBloc;

  AllFoodCubit({
    required AllFoodRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(AllFoodSearchStateModel.init());

  List<Foods> food = [];

  void categories(List<String> cats) {
    emit(state.copyWith(category: cats));
  }

  void cuisine(List<String> cuis) {
    emit(state.copyWith(cuisine: cuis));
  }

  void minPriceFilter(String value) {
    emit(state.copyWith(minPrice: value));
  }

  void maxPriceFilter(String value) {
    emit(state.copyWith(maxPrice: value));
  }

  void updateSearch(String query) {
    emit(state.copyWith(search: query));
  }

  void updateSort(String sort) {
    emit(state.copyWith(sort: sort));
  }

  Future<void> getAllFood() async {
    emit(state.copyWith(allFoodState: AllFoodLoading()));
    final uri = Utils.tokenWithCodeSearch(
        RemoteUrls.getSearch,
        state.initialPage.toString(),
        state.search,
        state.sort,
        state.category,
        state.cuisine,
        state.minPrice,
        state.maxPrice,
        state.languageCode);
    print('Search Url $uri');
    final result = await _repository.getAllFood(uri);
    result.fold((failure) {
      final errorState = AllFoodError(failure.message, failure.statusCode);
      emit(state.copyWith(allFoodState: errorState));
    }, (success) {
      if (state.initialPage == 1) {
        food = success;
        final loaded = AllFoodLoaded(food);
        emit(state.copyWith(allFoodState: loaded));
      } else {
        food.addAll(success);
        final loaded = AllFoodMoreLoaded(food);
        emit(state.copyWith(allFoodState: loaded));
      }
      state.initialPage++;
      if (success.isEmpty && state.initialPage != 1) {
        emit(state.copyWith(isListEmpty: true));
      }
    });
  }

  Future<void> applyFilters() async {
    state.initialPage = 1;
    food = [];
    getAllFood();
  }

  void clearFilters() {
    emit(
      state.copyWith(
        search: '',
        category: [],
        minPrice: '',
        maxPrice: '',
        cuisine: [],
        sort: '',
        initialPage: 1,
      ),
    );
  }

  void initPage() {
    emit(state.copyWith(initialPage: 1, isListEmpty: false));
  }
}
