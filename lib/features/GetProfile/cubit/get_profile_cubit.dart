import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Login/model/user_response_model.dart';

import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../repository/get_profile_repository.dart';
import 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  final GetProfileRepository _repository;
  final LoginBloc _loginBloc;

  GetProfileCubit({
    required GetProfileRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(GetProfileInitial());

  User? user;

  Future<void> getProfileData() async {
    emit(GetProfileLoading());
    final uri = Utils.tokenWithCode(
      RemoteUrls.getProfile,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Profile=============$uri');
    print('User Token: ${_loginBloc.userInformation?.token}');
    final result =
        await _repository.getProfileData(_loginBloc.userInformation!.token);
    result.fold(
      (l) => emit(GetProfileError(l.message, l.statusCode)),
      (success) {
        user = success;
        emit(GetProfileLoaded(success));
      },
    );
  }

  Future<void> updateProfile(Map<String, dynamic> body) async {
    emit(UpdateProfileLoading());

    final result = await _repository.updateProfile(
      _loginBloc.userInformation!.token,
      body,
    );

    result.fold(
      (failure) =>
          emit(UpdateProfileError(failure.message, failure.statusCode)),
      (user) {
        emit(UpdateProfileSuccess(user));
      },
    );
  }
}
