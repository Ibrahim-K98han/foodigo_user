import 'package:equatable/equatable.dart';
import 'package:foodigo/features/Privacy/model/privacy_response_model.dart';

class PrivacyPolicyState extends Equatable {
  const PrivacyPolicyState();
  @override
  List<Object?> get props => [];
}

class PrivacyPolicyInitial extends PrivacyPolicyState {
  const PrivacyPolicyInitial();
  @override
  List<Object?> get props => [];
}

class PrivacyPolicyLoading extends PrivacyPolicyState {
  const PrivacyPolicyLoading();
  @override
  List<Object?> get props => [];
}

class PrivacyPolicyLoaded extends PrivacyPolicyState {
  final PrivacyResponseModel privacyPolicy;
  const PrivacyPolicyLoaded({required this.privacyPolicy});
  @override
  List<Object?> get props => [privacyPolicy];
}

class PrivacyPolicyError extends PrivacyPolicyState {
  final String message;
  const PrivacyPolicyError({required this.message});
  @override
  List<Object?> get props => [message];
}

///Terms and condition
class TermsAndConditionInitial extends PrivacyPolicyState {
  const TermsAndConditionInitial();
  @override
  List<Object?> get props => [];
}

class TermsAndConditionLoading extends PrivacyPolicyState {
  const TermsAndConditionLoading();
  @override
  List<Object?> get props => [];
}

class TermsAndConditionLoaded extends PrivacyPolicyState {
  final TermsAndConditionResponseModel model;
  const TermsAndConditionLoaded({required this.model});
  @override
  List<Object?> get props => [model];
}

class TermsAndConditionError extends PrivacyPolicyState {
  final String message;
  const TermsAndConditionError({required this.message});
  @override
  List<Object?> get props => [message];
}

///Offer and Reward
class OfferAndRewardInitial extends PrivacyPolicyState {
  const OfferAndRewardInitial();
  @override
  List<Object?> get props => [];
}

class OfferAndRewardLoading extends PrivacyPolicyState {
  const OfferAndRewardLoading();
  @override
  List<Object?> get props => [];
}

class OfferAndRewardLoaded extends PrivacyPolicyState {
  final OfferAndReward model;
  const OfferAndRewardLoaded({required this.model});
  @override
  List<Object?> get props => [model];
}

class OfferAndRewardError extends PrivacyPolicyState {
  final String message;
  const OfferAndRewardError({required this.message});
  @override
  List<Object?> get props => [message];
}
