import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/add_to_cart/cubit/add_cart_state.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_response_model.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_state_model.dart';
import 'package:foodigo/features/add_to_cart/repository/add_cart_repository.dart';
import '../../../data/errors/failure.dart';
import '../../../utils/utils.dart';
import '../../Login/bloc/login_bloc.dart';

class AddCartCubit extends Cubit<AddCartStateModel> {
  final AddCartRepository _repository;
  final LoginBloc _loginBloc;

  AddCartCubit({
    required AddCartRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const AddCartStateModel());

  AddCartResponseModel? addCartResponseModel;

  // Select product size
  void selectSize(String size) {
    emit(state.copyWith(size: size));
  }

  // Select addons (list of IDs)
  void selectAddons(List<int> addons) {
    emit(state.copyWith(addons: addons));
  }

  // Update addon quantities
  void incrementAddonQty(Map<String, int> addonsQty) {
    emit(state.copyWith(addonsQty: Map.from(addonsQty)));
  }

  // Update addon quantities
  void decrementAddonQty(Map<String, int> addonsQty) {
    emit(state.copyWith(addonsQty: Map.from(addonsQty)));
  }

  // Update main product quantity
  void updateQty(int qty) {
    emit(state.copyWith(qty: qty));
  }

  // Increment main product quantity
  void incrementQty() {
    emit(state.copyWith(qty: state.qty + 1));
  }

  // Decrement main product quantity
  void decrementQty() {
    if (state.qty > 1) {
      emit(state.copyWith(qty: state.qty - 1));
    }
  }

  void setProductId(int productId) {
    emit(state.copyWith(productId: productId));
  }

  void incrementAddon(int addonId) {
    final updatedQty = Map<String, int>.from(state.addonsQty);
    updatedQty['$addonId'] = (updatedQty['$addonId'] ?? 0) + 1;
    emit(state.copyWith(addonsQty: updatedQty));
  }

  void decrementAddon(int addonId) {
    final updatedQty = Map<String, int>.from(state.addonsQty);
    if ((updatedQty['$addonId'] ?? 1) > 1) {
      updatedQty['$addonId'] = updatedQty['$addonId']! - 1;
      emit(state.copyWith(addonsQty: updatedQty));
    }
  }

  Future<void> addCart(BuildContext context, int productId) async {
    if (state.size.isEmpty) {
      Navigator.pop(context);
      Utils.failureSnackBar(
          context, "Please select a size before adding to cart");
      return;
    }
    emit(state.copyWith(
        productId: productId, addCartState: AddCartStateLoading()));
    final result =
        await _repository.addCart(state, _loginBloc.userInformation!.token);
    result.fold(
      (failure) {
        Navigator.pop(context);
        Utils.failureSnackBar(context, failure.message);
        emit(state.copyWith(
            addCartState:
                AddCartStateError(failure.message, failure.statusCode)));
      },
      (success) {
        addCartResponseModel = success;
        Navigator.pop(context);
        Utils.successSnackBar(context, success.message);
        emit(state.copyWith(addCartState: AddCartStateSuccess(success)));
        clear();
      },
    );
  }

  Future<void> updateCart(BuildContext context, int productId) async {
    if (state.size.isEmpty) {
      Navigator.pop(context);
      Utils.failureSnackBar(
          context, "Please select a size before adding to cart");
      return;
    }
    emit(state.copyWith(
        productId: productId, addCartState: UpdateCartStateLoading()));
    final result = await _repository.updateCart(
        state, _loginBloc.userInformation!.token, productId);
    result.fold(
      (failure) {
        Navigator.pop(context);
        Utils.failureSnackBar(context, failure.message);
        emit(state.copyWith(
            addCartState:
                UpdateCartStateError(failure.message, failure.statusCode)));
      },
      (success) {
        addCartResponseModel = success;
        Navigator.pop(context);
        Utils.successSnackBar(context, success.message);
        emit(state.copyWith(addCartState: UpdateCartStateSuccess(success)));
        clear();
      },
    );
  }

  void clear() {
    emit(state.copyWith(
      size: '',
      qty: 1,
      addons: [],
      addonsQty: {},
      addCartState: const AddCartInitial(),
    ));
  }
}
