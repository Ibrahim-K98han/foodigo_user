import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Order/model/order_details_model.dart';
import 'package:foodigo/features/Order/model/order_model.dart';

import '../repository/order_repository.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _repository;
  final LoginBloc _loginBloc;

  OrderCubit({
    required OrderRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const OrderStateInitial());

  List<OrderModel> orders = [];
  OrderModel? orderModel;
  OrderDetails? orderDetails;

  Future<void> getOrderData() async {
    emit(const OrderStateLoading());

    final result =
        await _repository.getOrderData(_loginBloc.userInformation!.token);

    result.fold(
      (l) => emit(OrderStateError(l.message, l.statusCode)),
      (success) {
        orders = success;
        emit(OrderStateSuccess(success));
      },
    );
  }

  Future<void> getOrderDetails(int id) async {
    emit(const OrderDetailsStateLoading());
    final result = await _repository.getOrderDetails(
        _loginBloc.userInformation!.token, id);

    result.fold(
      (l) => emit(OrderDetailsStateError(l.message, l.statusCode)),
      (success) {
        orderDetails = success;
        emit(OrderDetailsStateSuccess(success));
      },
    );
  }
}
