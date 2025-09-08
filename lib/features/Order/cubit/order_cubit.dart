import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Order/model/order_model.dart';
import 'package:foodigo/features/SingleRestaurant/model/single_restaurant_model.dart';
import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../../Cart/cubit/cart_state.dart';
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
        super(OrderStateInitial());

  List<OrderModel> orders = [];
  OrderModel? orderModel;

  Future<void> getOrderData() async {
    emit(const OrderStateLoading());

    final result = await _repository.getOrderData(_loginBloc.userInformation!.token);

    result.fold(
          (l) => emit(OrderStateError(l.message, l.statusCode)),
          (success) {
        orders = success;
        emit(OrderStateSuccess(success));
      },
    );
  }
}
