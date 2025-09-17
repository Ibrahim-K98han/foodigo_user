import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/Order/cubit/res_order_state.dart';
import 'package:foodigo/features/restaurant_features/Order/model/res_order_model.dart';

import '../../Login/bloc/restaurant_login_bloc.dart';
import '../repository/res_order_repository.dart';

class ResOrderCubit extends Cubit<ResOrderState> {
  final ResOrderRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  ResOrderCubit({
    required ResOrderRepository repository,
    required RestaurantLoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const ResOrderInitial());

  List<ResOrderModel>? resOrderModel;

  Future<void> getAllOrder() async {
    emit(const ResOrderLoading());
    final result =
        await _repository.getAllOrder(_loginBloc.userInformation!.token);
    result.fold(
      (l) => emit(ResOrderError(l.message, l.statusCode)),
      (success) {
        resOrderModel = success;
        emit(ResOrderLoaded(success));
      },
    );
  }
  /// Get Single Order Details
  Future<void> getOrderDetails(String orderId) async {
    emit(const ResOrderLoading());
    final result = await _repository.getOrderDetails(
        _loginBloc.userInformation!.token, orderId);
    result.fold(
          (l) => emit(ResOrderError(l.message, l.statusCode)),
          (success) {
        emit(ResOrderDetailsLoaded(success));
      },
    );
  }
}
