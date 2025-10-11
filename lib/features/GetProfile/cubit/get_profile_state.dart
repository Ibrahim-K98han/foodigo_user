import 'package:equatable/equatable.dart';
import 'package:foodigo/features/Login/model/user_response_model.dart';

abstract class GetProfileState extends Equatable {
  const GetProfileState();

  @override
  List<Object?> get props => [];
}

class GetProfileInitial extends GetProfileState {
  const GetProfileInitial();
  @override
  List<Object?> get props => [];
}

class GetProfileLoading extends GetProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetProfileLoaded extends GetProfileState {
  final User user;

  GetProfileLoaded(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetProfileError extends GetProfileState {
  final String message;
  final int statusCode;

  GetProfileError(this.message, this.statusCode);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

///Update Profile

class UpdateProfileInitial extends GetProfileState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileLoading extends GetProfileState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileSuccess extends GetProfileState {
  final String message;

  UpdateProfileSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateProfileError extends GetProfileState {
  final String message;
  final int statusCode;

  UpdateProfileError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}


class UpdateProfileLoaded extends GetProfileState {
  final User user;

  UpdateProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}
