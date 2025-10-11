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
  }) : _repository = repository,
       _loginBloc = loginBloc,
       super(const ResAddonStateModel());

  ResAddonModel? resAddonModel;
  ResAddons? addons;
  TranslateAddonModel? editAddons;

  void name(String name) => emit(state.copyWith(name: name));

  void price(String price) => emit(state.copyWith(price: price.toString()));

  void translateId(String translateId) =>
      emit(state.copyWith(translateId: translateId));

  /// Get Addon List
  Future<void> getAddon() async {
    print("call get addon");
    emit(state.copyWith(resAddonsState: const ResAddonsLoading()));
    final result = await _repository.getAddonList(
      _loginBloc.userInformation!.token,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          resAddonsState: ResAddonsError(failure.message, failure.statusCode),
        ),
      ),
      (success) {
        resAddonModel = success;
        emit(state.copyWith(resAddonsState: ResAddonsLoaded(success)));
      },
    );
  }

  /// Store Addon
  Future<void> storeAddon() async {
    emit(state.copyWith(resAddonsState: const AddAddonsLoading()));
    try {
      final result = await _repository.storeAddon(
        state,
        _loginBloc.userInformation!.token,
      );
      await getAddon();
      result.fold(
        (failure) => emit(
          state.copyWith(
            resAddonsState: AddAddonsError(failure.message, failure.statusCode),
          ),
        ),
        (success) {
          final updatedList = List<ResAddons>.from(
            resAddonModel?.resAddons ?? [],
          )..addAll(success.resAddons);
          resAddonModel = ResAddonModel(resAddons: updatedList);

          emit(
            state.copyWith(
              resAddonsState: AddAddonsLoaded(
                resAddonModel! as TranslateAddonModel,
              ),
            ),
          );
          clear();
        },
      );
    } catch (e) {
      emit(state.copyWith(resAddonsState: AddAddonsError(e.toString(), 500)));
    }
  }

  /// Update Addon
  Future<void> updateAddon(String id) async {
    emit(state.copyWith(resAddonsState: const UpdateAddonsLoading()));

    final uri = Utils.tokenWithCode(
      RemoteUrls.updateAddon(id),
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );

    print('Update Addon $uri');

    try {
      final result = await _repository.updateAddon(
        state,
        uri,
        _loginBloc.userInformation!.token,
        id,
      );

      await getAddon();

      result.fold(
        (failure) => emit(
          state.copyWith(
            resAddonsState: UpdateAddonsError(
              failure.message,
              failure.statusCode,
            ),
          ),
        ),
        (success) {
          if (resAddonModel != null) {
            final updatedList =
                resAddonModel!.resAddons.map((e) {
                  if (e.id == success.id) return success;
                  return e;
                }).toList();
            resAddonModel = ResAddonModel(resAddons: updatedList);
          }
          addons = success;
          emit(
            state.copyWith(
              resAddonsState: const ResAddonsSuccess(
                "Addon updated successfully",
              ),
            ),
          );
          // Clear the form state
          clear();
        },
      );
    } catch (e) {
      emit(
        state.copyWith(resAddonsState: UpdateAddonsError(e.toString(), 500)),
      );
    }
  }

  /// ----------------- Delete Addon -----------------
  Future<void> deleteAddon(String productId) async {
    emit(state.copyWith(resAddonsState: const DeleteAddonLoading()));
    final result = await _repository.deleteAddon(
      _loginBloc.userInformation!.token,
      productId,
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          resAddonsState: DeleteAddonError(l.message, l.statusCode),
        ),
      ),
      (message) {
        // Remove the deleted addon from local list
        if (resAddonModel != null) {
          final updatedList =
              resAddonModel!.resAddons
                  .where((addon) => addon.id.toString() != productId)
                  .toList();
          resAddonModel = ResAddonModel(resAddons: updatedList);
        }

        emit(
          state.copyWith(
            resAddonsState: DeleteAddonSuccess(
              message,
            ), // "Addon deleted successfully"
          ),
        );
      },
    );
  }

  /// ----------------- Edit Addon -----------------
  Future<void> editAddon(String addonId) async {
    emit(state.copyWith(resAddonsState: const EditAddonsLoading()));

    final uri = Utils.tokenWithCode(
      RemoteUrls.editAddon(addonId),
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Edit Addon Url:$uri');
    final result = await _repository.editAddon(
      _loginBloc.userInformation!.token,
      addonId,
      uri,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          resAddonsState: EditAddonsError(failure.message, failure.statusCode),
        ),
      ),
      (success) {
        editAddons = success;
        if (editAddons != null) {
          final addon = editAddons;
          emit(
            state.copyWith(
              name: addon!.addon!.name,
              price: addon.addon!.price,
              translateId: addon.addonTranslate?.id.toString(),
              resAddonsState: EditAddonsLoaded(success),
            ),
          );
        }
      },
    );
  }

  void clear() {
    emit(
      const ResAddonStateModel(
        name: '',
        price: '',
        resAddonsState: ResAddonsInitial(),
      ),
    );
  }
}
