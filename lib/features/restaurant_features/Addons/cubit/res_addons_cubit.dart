import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Login/bloc/restaurant_login_bloc.dart';
import '../model/res_addon_model.dart';
import '../repository/res_addon_repository.dart';
import 'res_addons_state.dart';

class ResAddonsCubit extends Cubit<ResAddonsState> {
  final ResAddonRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  ResAddonsCubit({
    required ResAddonRepository repository,
    required RestaurantLoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const ResAddonsInitial());

  ResAddonModel? resAddonModel;

  /// Get Addon List
  Future<void> getAddon() async {
    emit(const ResAddonsLoading());
    final result =
        await _repository.getAddonList(_loginBloc.userInformation!.token);

    result.fold(
      (failure) => emit(ResAddonsError(failure.message, failure.statusCode)),
      (success) {
        resAddonModel = success;
        emit(ResAddonsLoaded(success));
      },
    );
  }
}
