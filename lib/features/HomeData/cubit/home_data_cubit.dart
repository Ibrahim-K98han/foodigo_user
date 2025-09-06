import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/HomeData/home_data_model.dart';
import 'package:foodigo/features/HomeData/repository/home_data_repository.dart';

import 'home_data_state.dart';

class HomeDataCubit extends Cubit<HomeDataState> {
  final HomeDataRepository _repository;

  HomeDataCubit({required HomeDataRepository repository})
      : _repository = repository,
        super(const HomeDataInitial());

  HomeModel? homeModel;

  Future<void> getHomeDataData() async {
    emit(HomeDataLoading());

    final result = await _repository.getHomeDataData();
    result.fold(
      (l) => emit(HomeDataError(l.message, l.statusCode)),
      (success) {
        homeModel = success;
        emit(HomeDataLoaded(success));
      },
    );
  }
}
