import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/OrderStatus/cubit/order_status_state.dart';
import 'package:foodigo/features/restaurant_features/OrderStatus/model/change_order_status_state_model.dart';

import '../../Login/bloc/restaurant_login_bloc.dart';
import '../model/order_status_model.dart';
import '../repository/order_status_repository.dart';

class OrderStatusCubit extends Cubit<ChangeOrderStatusStateModel> {
  final OrderStatusRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  OrderStatusCubit({
    required OrderStatusRepository repository,
    required RestaurantLoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const ChangeOrderStatusStateModel());

  OrderStatusModel? resOrderModel;

  String _currentStatusText = '';

  void changeStatus(String orderStatus) {
    print('Status ================$orderStatus');
    _currentStatusText = orderStatus;
    emit(state.copyWith(orderStatus: orderStatus));
  }

  Future<void> changeOrderStatus(String orderId, String orderStatus) async {
    emit(
      state.copyWith(
        orderStatusState: const OrderStatusLoading(),
        orderStatus: _currentStatusText,
      ),
    );

    final result = await _repository.chageOrderStatus(
      _loginBloc.userInformation!.token,
      orderId,
      orderStatus,
    );

    result.fold(
          (l) => emit(
        state.copyWith(
          orderStatusState: OrderStatusError(l.message, l.statusCode),
        ),
      ),
          (success) {
        resOrderModel = success;
        final successMessage = success.message.isNotEmpty
            ? success.message
            : 'Order status updated to $_currentStatusText successfully!';

        emit(
          state.copyWith(
            orderStatusState: OrderStatusSuccess(
              success,
              message: successMessage,
            ),
          ),
        );
      },
    );
  }
}