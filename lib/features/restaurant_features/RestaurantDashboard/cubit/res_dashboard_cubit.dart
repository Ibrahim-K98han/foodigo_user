import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/model/res_dashboard_model.dart';

import '../../Login/bloc/restaurant_login_bloc.dart';
import '../repository/res_dashboard_repository.dart';
import 'res_dashboard_state.dart';

class ResDashboardCubit extends Cubit<ResDashboardState> {
  final ResDashboardRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  ResDashboardCubit({
    required ResDashboardRepository repository,
    required RestaurantLoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const ResDashboardInitial());

  ResDashboardModel? resDashboardModel;

  ///Show Review
  Future<void> getDashboardData() async {
    emit(const ResDashboardLoading());
    final result = await _repository
        .getResDashboardData(_loginBloc.userInformation!.token);
    result.fold(
      (l) => emit(ResDashboardError(l.message, l.statusCode)),
      (success) {
        resDashboardModel = success;
        emit(ResDashboardLoaded(success));
      },
    );
  }
}
