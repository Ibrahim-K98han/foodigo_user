import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/HomeData/cubit/search_state_model.dart';
import 'package:foodigo/features/HomeData/feature_product_model.dart';
import 'package:foodigo/features/HomeData/home_data_model.dart';
import 'package:foodigo/features/HomeData/repository/home_data_repository.dart';

import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../../Login/bloc/login_bloc.dart';
import 'home_data_state.dart';

class SearchDataCubit extends Cubit<SearchStateModel> {
  final HomeDataRepository _repository;
  final LoginBloc _loginBloc;

  SearchDataCubit({
    required HomeDataRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(SearchStateModel.init());

  List<FeaturedProducts> feature = [];

  FeaturedProducts? featuredProducts;

  void search(String text) {
    emit(state.copyWith(search: text));
    print("key: ${state.search}");
  }

  void categories(List<String> category) {
    emit(state.copyWith(
      category: category,
    ));
  }

  void cuisine(List<String> cuisine) {
    emit(state.copyWith(
      cuisine: cuisine,
    ));
  }

  void minPrice(String text) {
    emit(state.copyWith(
      minPrice: text,
    ));
  }

  void maxPrice(String text) {
    emit(state.copyWith(
      maxPrice: text,
    ));
  }

  Future<void> getFoodList() async {
    emit(state.copyWith(homeDataState: HomeDataLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.getSearch,
      state.search,
      state.minPrice,
    );
    print("search url : $uri");
    final result = await _repository.getSearchAttribute(uri);
    result.fold((failure) {
      final errorState = HomeDataError(failure.message, failure.statusCode);
      emit(state.copyWith(homeDataState: errorState));
    }, (success) {
      if (state.initialPage == 1) {
        feature = success as List<FeaturedProducts>;
        final loaded = HomeDataLoaded(feature as HomeModel);
        emit(state.copyWith(homeDataState: loaded));
      } else {
        feature.addAll(success as Iterable<FeaturedProducts>);
        final loaded = HomeDataLoaded(feature as HomeModel);
        emit(state.copyWith(homeDataState: loaded));
      }
      state.initialPage++;
    });
  }

  Future<void> applyFilters() async {
    feature = [];

    getFoodList();
  }

  void clearFilters() {
    emit(
      state.copyWith(
        search: '',
        category: [],
        cuisine: [],
        maxPrice: '',
        minPrice: '',
        sortBy: '',
      ),
    );
    applyFilters();
  }

  Future<void> getSearchAttribute() async {
    if (_loginBloc.userInformation?.token.isNotEmpty ?? false) {
      emit(state.copyWith(homeDataState: HomeDataLoading()));
      final uri = Utils.tokenWithCode(
        RemoteUrls.getSearch,
        _loginBloc.userInformation?.token ?? '',
        _loginBloc.state.languageCode,
      );
      final result = await _repository.getSearchAttribute(uri);
      result.fold((failure) {
        final errorState = HomeDataError(failure.message, failure.statusCode);
        emit(state.copyWith(homeDataState: errorState));
      }, (success) {
        featuredProducts = success;
        final successState = SearchDataLoaded(success);
        emit(state.copyWith(homeDataState: successState));
      });
    } else {
      const errors = HomeDataError('', 401);
      emit(state.copyWith(homeDataState: errors));
    }
  }
}
