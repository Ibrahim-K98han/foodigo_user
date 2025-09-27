import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Splash/model/splash_response_model.dart';

import '../repository/splash_repository.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepository _repository;
  final LoginBloc _loginBloc;

  SplashCubit({
    required SplashRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const SplashStateInitial());

  SplashResponseModel? splashResponseModel;

  Future<void> getSplash() async {
    emit(const SplashStateLoading());

    final result =
        await _repository.getSplash();

    result.fold(
      (l) => emit(SplashStateError(l.message, l.statusCode)),
      (success) {
        splashResponseModel = success;
        emit(SplashStateLoaded(success));
      },
    );
  }
}
