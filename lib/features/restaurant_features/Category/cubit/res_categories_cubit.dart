import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Login/bloc/restaurant_login_bloc.dart';
import '../model/res_category_model.dart';
import '../repository/res_category_repository.dart';
import 'res_categories_state.dart';

class ResCategoriesCubit extends Cubit<ResCategoriesState> {
  final ResCategoryRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  ResCategoriesCubit({
    required ResCategoryRepository repository,
    required RestaurantLoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const ResCategoriesInitial());

  ResCategoryModel? categoryModel;

  /// Get Category List
  Future<void> getCategories() async {
    emit(const ResCategoriesLoading());
    final result =
        await _repository.getCategoryList(_loginBloc.userInformation!.token);

    result.fold(
      (failure) =>
          emit(ResCategoriesError(failure.message, failure.statusCode)),
      (success) {
        categoryModel = success;
        emit(ResCategoriesLoaded(success));
      },
    );
  }
}
