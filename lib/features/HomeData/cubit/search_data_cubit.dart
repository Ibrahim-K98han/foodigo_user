import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/HomeData/category_model.dart';
import 'package:foodigo/features/HomeData/cubit/search_state_model.dart';
import 'package:foodigo/features/HomeData/cuisines_model.dart';
import 'package:foodigo/features/HomeData/feature_product_model.dart';
import 'package:foodigo/features/HomeData/repository/home_data_repository.dart';

import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../../Login/bloc/login_bloc.dart';
import '../home_data_model.dart';
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

  void search(String text) {
    emit(state.copyWith(search: text, ));
  }

  void categories(List<Categories> category) {
    emit(state.copyWith(category: category, ));
  }

  void cuisine(List<Cuisines> cuisine) {
    emit(state.copyWith(cuisine: cuisine,));
  }

  void minPrice(String text) {
    emit(state.copyWith(minPrice: text,));
  }

  void maxPrice(String text) {
    emit(state.copyWith(maxPrice: text, ));
  }
  Future<void> getFoodList() async {
    emit(state.copyWith(homeDataState: HomeDataLoading()));

    final uri = Utils.tokenWithCode(
      RemoteUrls.getSearch,
      state.search,
      state.minPrice,
      // category/cuisine/sortBy query এখানে যোগ করতে হবে
    );

    final result = await _repository.getSearchAttribute(uri);

    result.fold((failure) {
      emit(state.copyWith(homeDataState: HomeDataError(failure.message, failure.statusCode)));
    }, (success) {
      final homeModel = success as HomeModel;

      // এখানে filteredProducts update করা হলো
      final filtered = homeModel.featuredProducts ?? [];

      emit(state.copyWith(
        homeDataState: HomeDataLoaded(homeModel),
        filteredProducts: filtered,
      ));
    });
  }


  Future<void> applyFilters() async {
    await getFoodList();
  }

  void clearFilters() {
    emit(SearchStateModel.reset());
    applyFilters();
  }
}
