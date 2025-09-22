// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../cubit/res_change_pass_state.dart';

class ResChangePassStateModel extends Equatable {
  final String currentPassword;
  final String password;
  final String confirmPassword;
  final bool showCurrentPassword;
  final bool showPassword;
  final bool showConPassword;
  final ResChangePassState changePassState;

  const ResChangePassStateModel({
    required this.currentPassword,
    required this.password,
    required this.confirmPassword,
    this.showCurrentPassword = true,
    this.showPassword = true,
    this.showConPassword = true,
    this.changePassState = const ResChangePassInitial(),
  });

  ResChangePassStateModel copyWith({
    String? currentPassword,
    String? password,
    String? confirmPassword,
    bool? showCurrentPassword,
    bool? showPassword,
    bool? showConPassword,
    ResChangePassState? changePassState,
  }) {
    return ResChangePassStateModel(
      currentPassword: currentPassword ?? this.currentPassword,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showCurrentPassword: showCurrentPassword ?? this.showCurrentPassword,
      showPassword: showPassword ?? this.showPassword,
      showConPassword: showConPassword ?? this.showConPassword,
      changePassState: changePassState ?? this.changePassState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'current_password': currentPassword,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }

  factory ResChangePassStateModel.fromMap(Map<String, dynamic> map) {
    return ResChangePassStateModel(
      currentPassword: map['current_password'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['password_confirmation'] ?? '',
    );
  }

  ResChangePassStateModel clear() {
    return const ResChangePassStateModel(
      password: '',
      currentPassword: '',
      confirmPassword: '',
      showPassword: true,
      showCurrentPassword: true,
      showConPassword: true,
      changePassState: ResChangePassInitial(),
    );
  }

  static ResChangePassStateModel init() {
    return const ResChangePassStateModel(
      password: '',
      currentPassword: '',
      confirmPassword: '',
      showCurrentPassword: true,
      showPassword: true,
      showConPassword: true,
      changePassState: ResChangePassInitial(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResChangePassStateModel.fromJson(String source) =>
      ResChangePassStateModel.fromMap(
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
        changePassState,
      ];
}
