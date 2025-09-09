import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Subscription/cubit/subscription_state.dart';
import 'package:foodigo/features/Subscription/model/payment_to_map_model.dart';
import 'package:foodigo/features/Subscription/repository/subscription_repository.dart';

import '../model/bank_payment_request_model.dart';

class SubscriptionCubit extends Cubit<PaymentToMapModel> {
  final SubscriptionRepository _repository;
  final LoginBloc _loginBloc;

  SubscriptionCubit({
    required SubscriptionRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(PaymentToMapModel.init());

  Future<void> payWithBank({
    required String transactionInfo,
    required String addressId,
    required String orderType,
  }) async {
    emit(
        state.copyWith(subscriptionListState: const BankPaymentStateLoading()));

    final body = BankPaymentRequestModel(
      transactionInfo: transactionInfo,
      orderData: OrderDataRequest(
        addressId: addressId,
        orderType: orderType,
      ),
    );
    final result =
        await _repository.payWithBank(body, _loginBloc.userInformation!.token);

    result.fold(
      (failure) {
        emit(state.copyWith(
            subscriptionListState:
                BankPaymentStateError(failure.message, 500)));
      },
      (success) {
        emit(state.copyWith(
            subscriptionListState: BankPaymentStateLoaded(success.message)));
      },
    );
  }

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  Uri webPaymentInfo(String url) {
    final body = state.copyWith(
      token: 'Bearer ${_loginBloc.userInformation!.token}',
    );
    print('Token ${body.token}');
    final uri = Uri.parse(url).replace(queryParameters: body.toMap());
    return uri;
  }
}
