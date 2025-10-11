import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/GetProfile/model/profile_state_model.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Login/model/user_response_model.dart';

import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../repository/get_profile_repository.dart';
import 'get_profile_state.dart';

class GetProfileCubit extends Cubit<ProfileStateModel> {
  final GetProfileRepository _repository;
  final LoginBloc _loginBloc;

  GetProfileCubit({
    required GetProfileRepository repository,
    required LoginBloc loginBloc,
  }) : _repository = repository,
       _loginBloc = loginBloc,
       super(const ProfileStateModel());

  User? user;

  void name(String name) => emit(state.copyWith(name: name));
  void email(String email) => emit(state.copyWith(email: email));
  void phone(String phone) => emit(state.copyWith(phone: phone));
  void address(String address) => emit(state.copyWith(address: address));
  void image(String image) => emit(state.copyWith(image: image));

  Future<void> getProfileData() async {
    emit(state.copyWith(getProfileState: GetProfileLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.getProfile,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Profile=============$uri');
    print('User Token: ${_loginBloc.userInformation?.token}');
    final result = await _repository.getProfileData(
      _loginBloc.userInformation!.token,
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          getProfileState: GetProfileError(l.message, l.statusCode),
        ),
      ),
      (success) {
        user = success;
        if (user != null) {
          emit(
            state.copyWith(
              image: user!.image,
              name: user!.name,
              email: user!.email,
              phone: user!.phone,
              address: user!.address,
            ),
          );
        }
        final successState = GetProfileLoaded(success);
        emit(state.copyWith(getProfileState: successState));
      },
    );
  }

  Future<void> updateProfile() async {
    emit(state.copyWith(getProfileState: UpdateProfileLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.updateProfile,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Update Profile $uri');
    try {
      final result = await _repository.updateProfile(
        state,
        uri,
        _loginBloc.userInformation!.token,
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              getProfileState: UpdateProfileError(
                failure.message,
                failure.statusCode,
              ),
            ),
          );
        },
        (success) {
          user = success;
          emit(state.copyWith(getProfileState: UpdateProfileLoaded(success)));
          // clearState();
        },
      );
    } catch (e) {
      emit(
        state.copyWith(getProfileState: UpdateProfileError(e.toString(), 500)),
      );
    }
  }

  void clearState() {
    emit(const ProfileStateModel());
  }
}
