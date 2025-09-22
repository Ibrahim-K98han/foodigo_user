import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/Addons/model/res_addon_state_model.dart';
import 'package:foodigo/utils/utils.dart';
import '../../../../data/remote_url.dart';
import '../../Login/bloc/restaurant_login_bloc.dart';
import '../model/res_addon_model.dart';
import '../repository/res_addon_repository.dart';
import 'res_addons_state.dart';

class ResAddonsCubit extends Cubit<ResAddonStateModel> {
  final ResAddonRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  ResAddonsCubit({
    required ResAddonRepository repository,
    required RestaurantLoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const ResAddonStateModel());

  ResAddonModel? resAddonModel;

  void name(String name) => emit(state.copyWith(name: name));

  void price(String price) => emit(state.copyWith(price: price));

  /// Get Addon List
  Future<void> getAddon() async {
    emit(state.copyWith(resAddonsState: const ResAddonsLoading()));
    final result =
        await _repository.getAddonList(_loginBloc.userInformation!.token);

    result.fold(
      (failure) => emit(state.copyWith(
          resAddonsState: ResAddonsError(failure.message, failure.statusCode))),
      (success) {
        resAddonModel = success;
        emit(state.copyWith(resAddonsState: ResAddonsLoaded(success)));
      },
    );
  }

  /// Store Addon
  Future<void> storeAddon() async {
    emit(state.copyWith(resAddonsState: const ResAddonsLoading()));

    try {
      final result = await _repository.storeAddon(
          state, _loginBloc.userInformation!.token);
      await getAddon();
      result.fold(
        (failure) => emit(state.copyWith(
            resAddonsState:
                ResAddonsError(failure.message, failure.statusCode))),
        (success) {
          final updatedList =
              List<ResAddons>.from(resAddonModel?.resAddons ?? [])
                ..addAll(success.resAddons ?? []);
          resAddonModel = ResAddonModel(resAddons: updatedList);

          emit(state.copyWith(resAddonsState: ResAddonsLoaded(resAddonModel!)));
          clear();
        },
      );
    } catch (e) {
      emit(state.copyWith(resAddonsState: ResAddonsError(e.toString(), 500)));
    }
  }

  /// Update Addon
  Future<void> updateAddon(
      String id, String langCode, String translateId) async {
    emit(state.copyWith(resAddonsState: const UpdateAddonsLoading()));
    try {
      final result = await _repository.updateAddon(
          state, _loginBloc.userInformation!.token, id);
      await getAddon();
      result.fold(
        (failure) => emit(state.copyWith(
            resAddonsState:
                UpdateAddonsError(failure.message, failure.statusCode))),
        (success) {
          final updatedList =
              List<ResAddons>.from(resAddonModel?.resAddons ?? [])
                ..addAll(success.resAddons ?? []);
          resAddonModel = ResAddonModel(resAddons: updatedList);

          emit(state.copyWith(
              resAddonsState: UpdateAddonsLoaded(resAddonModel!)));
          clear();
        },
      );
    } catch (e) {
      emit(
          state.copyWith(resAddonsState: UpdateAddonsError(e.toString(), 500)));
    }
  }

  /// ----------------- Delete Addon -----------------
  Future<void> deleteAddon(String productId) async {
    emit(state.copyWith(resAddonsState: const DeleteAddonLoading()));
    final result = await _repository.deleteAddon(
        _loginBloc.userInformation!.token, productId);
    result.fold(
        (l) => emit(state.copyWith(
            resAddonsState: DeleteAddonError(l.message, l.statusCode))),
        (success) async {
      await getAddon();
      emit(state.copyWith(
          resAddonsState: DeleteAddonSuccess(success.toString())));
    });
  }

  /// ----------------- Edit Addon -----------------
  Future<void> editAddon(String addonId) async {
    emit(state.copyWith(resAddonsState: EditAddonsLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.editAddon(addonId),
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Edit Addon URL: $uri');

    final result = await _repository.editAddon(
      _loginBloc.userInformation!.token,
      addonId,
      uri,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        resAddonsState: EditAddonsError(failure.message, failure.statusCode),
      )),
      (success) {
        resAddonModel = success;
        if (resAddonModel != null && resAddonModel!.resAddons.isNotEmpty) {
          final firstAddon = resAddonModel!.resAddons.first;
          emit(state.copyWith(
            name: firstAddon.addonTranslate?.name ?? '',
            price: firstAddon.price,
            resAddonsState: EditAddonsLoaded(success),
          ));
        } else {
          emit(state.copyWith(
            resAddonsState: const EditAddonsError("No addon data found", 404),
          ));
        }
      },
    );
  }

  void clear() {
    emit(const ResAddonStateModel(
      name: '',
      price: '',
      resAddonsState: ResAddonsInitial(),
    ));
  }
}
