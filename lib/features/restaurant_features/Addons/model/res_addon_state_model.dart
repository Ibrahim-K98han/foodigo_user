// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:foodigo/features/restaurant_features/Addons/cubit/res_addons_state.dart';

class ResAddonStateModel extends Equatable {
  final String name;
  final String price;
  final List<String> addons;
  final String translateId;
  final bool isSelected;
  final ResAddonsState resAddonsState;

  const ResAddonStateModel({
    this.name = '',
    this.price = '',
    this.translateId = '',
    this.addons = const [],
    this.isSelected = false,
    this.resAddonsState = const ResAddonsInitial(),
  });

  ResAddonStateModel copyWith({
    String? name,
    String? price,
    String? translateId,
    List<String>? addons,
    bool? isSelected,
    ResAddonsState? resAddonsState,
  }) {
    return ResAddonStateModel(
      name: name ?? this.name,
      price: price ?? this.price,
      translateId: translateId ?? this.translateId,
      addons: addons ?? this.addons,
      isSelected: isSelected ?? this.isSelected,
      resAddonsState: resAddonsState ?? this.resAddonsState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'translate_id': translateId,
      'addon_items':addons,
      'is_selected': isSelected,
    };
  }

  factory ResAddonStateModel.fromMap(Map<String, dynamic> map) {
    return ResAddonStateModel(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      translateId: map['translate_id'] ?? '',
      addons: map['addon_items'] != null
          ? List<String>.from(jsonDecode(map['addon_items']))
          : [],
      isSelected: map['is_selected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResAddonStateModel.fromJson(String source) =>
      ResAddonStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
    name,
    price,
    translateId,
    addons,
    isSelected,
    resAddonsState,
  ];
}
