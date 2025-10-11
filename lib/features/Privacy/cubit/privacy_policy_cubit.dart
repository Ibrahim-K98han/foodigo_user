import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Privacy/cubit/privacy_policy_state.dart';
import 'package:foodigo/features/Privacy/model/privacy_response_model.dart';
import 'package:foodigo/features/Privacy/repository/privacy_policy_repository.dart';

class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
  final PrivacyPolicyRepository _repository;
  final LoginBloc _loginBloc;

  PrivacyPolicyCubit({
    required PrivacyPolicyRepository repository,
    required LoginBloc loginBloc,
  }) : _repository = repository,
       _loginBloc = loginBloc,
       super(const PrivacyPolicyState());

  PrivacyResponseModel? privacyPolicy;
  TermsAndConditionResponseModel? termsAndCondition;
  OfferAndReward? offerAndReward;

  Future<void> fetchPrivacyPolicy() async {
    emit(const PrivacyPolicyLoading());
    final langCode = _loginBloc.state.languageCode;
    final result = await _repository.getPrivacyPolicy(langCode);
    result.fold(
      (failure) {
        emit(PrivacyPolicyError(message: failure.message));
      },
      (data) {
        privacyPolicy = data;
        emit(PrivacyPolicyLoaded(privacyPolicy: data));
      },
    );
  }

  Future<void> fetchTermsAndCondition() async {
    emit(const TermsAndConditionLoading());
    final langCode = _loginBloc.state.languageCode;
    final result = await _repository.getTermsAndCondition(langCode);
    result.fold(
      (failure) {
        emit(TermsAndConditionError(message: failure.message));
      },
      (data) {
        termsAndCondition = data;
        emit(TermsAndConditionLoaded(model: data));
      },
    );
  }

  Future<void> fetchOfferAndReward() async {
    emit(const OfferAndRewardLoading());
    final langCode = _loginBloc.state.languageCode;
    final result = await _repository.getOfferAndReward(langCode);
    result.fold(
      (failure) {
        emit(OfferAndRewardError(message: failure.message));
      },
      (data) {
        offerAndReward = data;
        emit(OfferAndRewardLoaded(model: data));
      },
    );
  }
}
