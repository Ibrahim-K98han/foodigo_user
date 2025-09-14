// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../cubit/change_profile_pass_state.dart';

class ChangeProfilePassStateModel extends Equatable {
  final String currentPassword;
  final String password;
  final String confirmPassword;
  final bool showCurrentPassword;
  final bool showPassword;
  final bool showConPassword;
  final ChangeProfilePassState changeProfilePassState;

  const ChangeProfilePassStateModel({
    required this.currentPassword,
    required this.password,
    required this.confirmPassword,
    this.showCurrentPassword = true,
    this.showPassword = true,
    this.showConPassword = true,
    this.changeProfilePassState = const ChangeProfilePassInitial(),
  });

  ChangeProfilePassStateModel copyWith({
    String? currentPassword,
    String? password,
    String? confirmPassword,
    bool? showCurrentPassword,
    bool? showPassword,
    bool? showConPassword,
    ChangeProfilePassState? changeProfilePassState,
  }) {
    return ChangeProfilePassStateModel(
      currentPassword: currentPassword ?? this.currentPassword,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showCurrentPassword: showCurrentPassword ?? this.showCurrentPassword,
      showPassword: showPassword ?? this.showPassword,
      showConPassword: showConPassword ?? this.showConPassword,
      changeProfilePassState:
          changeProfilePassState ?? this.changeProfilePassState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'current_password': currentPassword,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }

  factory ChangeProfilePassStateModel.fromMap(Map<String, dynamic> map) {
    return ChangeProfilePassStateModel(
      currentPassword: map['current_password'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['password_confirmation'] ?? '',
    );
  }

  ChangeProfilePassStateModel clear() {
    return const ChangeProfilePassStateModel(
      password: '',
      currentPassword: '',
      confirmPassword: '',
      showPassword: true,
      showCurrentPassword: true,
      showConPassword: true,
      changeProfilePassState: ChangeProfilePassInitial(),
    );
  }

  static ChangeProfilePassStateModel init() {
    return const ChangeProfilePassStateModel(
      password: '',
      currentPassword: '',
      confirmPassword: '',
      showCurrentPassword: true,
      showPassword: true,
      showConPassword: true,
      changeProfilePassState: ChangeProfilePassInitial(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangeProfilePassStateModel.fromJson(String source) =>
      ChangeProfilePassStateModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        password,
        currentPassword,
        confirmPassword,
        showCurrentPassword,
        showPassword,
        showConPassword,
        changeProfilePassState,
      ];
}
