import 'package:foodigo/features/Login/model/user_response_model.dart';

abstract class GetProfileState {}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoading extends GetProfileState {}

class GetProfileLoaded extends GetProfileState {
  final User user;

  GetProfileLoaded(this.user);
}

class GetProfileError extends GetProfileState {
  final String message;
  final int statusCode;

  GetProfileError(this.message, this.statusCode);
}
