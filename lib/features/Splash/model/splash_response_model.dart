import 'dart:convert';
import 'package:equatable/equatable.dart';

class SplashResponseModel extends Equatable {
  final List<One> splashScreens;

  const SplashResponseModel({required this.splashScreens});

  SplashResponseModel copyWith({List<One>? splashScreens}) {
    return SplashResponseModel(splashScreens: splashScreens ?? this.splashScreens);
  }

  Map<String, dynamic> toMap() {
    return {
      'splash_screens': {
        for (var i = 0; i < splashScreens.length; i++) 'screen_${i + 1}': splashScreens[i].toMap()
      },
    };
  }

  factory SplashResponseModel.fromMap(Map<String, dynamic> map) {
    final screensMap = map['splash_screens'] as Map<String, dynamic>? ?? {};
    final screens = screensMap.values
        .map((e) => One.fromMap(e as Map<String, dynamic>))
        .toList();
    return SplashResponseModel(splashScreens: screens);
  }

  String toJson() => json.encode(toMap());

  factory SplashResponseModel.fromJson(String source) =>
      SplashResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [splashScreens];
}

class One extends Equatable {
  final String image;
  final String heading;
  final String subheading;

  const One({
    required this.image,
    required this.heading,
    required this.subheading,
  });

  One copyWith({String? image, String? heading, String? subheading}) {
    return One(
      image: image ?? this.image,
      heading: heading ?? this.heading,
      subheading: subheading ?? this.subheading,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'heading': heading,
      'subheading': subheading,
    };
  }

  factory One.fromMap(Map<String, dynamic> map) {
    return One(
      image: map['image'] ?? '',
      heading: map['heading'] ?? '',
      subheading: map['subheading'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory One.fromJson(String source) =>
      One.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [image, heading, subheading];
}
