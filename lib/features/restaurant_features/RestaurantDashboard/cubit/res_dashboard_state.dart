import 'package:equatable/equatable.dart';
import 'package:foodigo/features/Review/model/review_model.dart';

import '../model/res_dashboard_model.dart';

abstract class ResDashboardState extends Equatable {
  const ResDashboardState();

  @override
  List<Object?> get props => [];
}

class ResDashboardInitial extends ResDashboardState {
  const ResDashboardInitial();

  @override
  List<Object?> get props => [];
}

class ResDashboardLoading extends ResDashboardState {
  const ResDashboardLoading();

  @override
  List<Object?> get props => [];
}

class ResDashboardLoaded extends ResDashboardState {
  final ResDashboardModel resDashboardModel;

  const ResDashboardLoaded(this.resDashboardModel);

  @override
  List<Object?> get props => [resDashboardModel];
}

class ResDashboardSuccess extends ResDashboardState {
  final ResDashboardModel resDashboardModel;

  const ResDashboardSuccess(this.resDashboardModel);

  @override
  List<Object?> get props => [resDashboardModel];
}

class ResDashboardError extends ResDashboardState {
  final String message;
  final int statusCode;

  const ResDashboardError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
