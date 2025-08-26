// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:foodigo/features/HomeData/category_model.dart';
import 'package:foodigo/features/HomeData/cuisines_model.dart';
import 'package:foodigo/features/HomeData/feature_product_model.dart';
import 'package:foodigo/features/HomeData/restaurant_model.dart';

class HomeModel extends Equatable {
  // final Homepage? homepage;
  // final HomeTranslate? homeTranslate;
  final List<Categories>? categories;
  final List<FeaturedProducts>? featuredProducts;
  final List<Cuisines>? cuisines;
  final List<Restaurants>? restaurants;
  final List<FeaturedProducts>? newArrivalProducts;
  const HomeModel({
    this.categories,
    this.featuredProducts,
    this.cuisines,
    this.restaurants,
    this.newArrivalProducts,
  });

  HomeModel copyWith({
    List<Categories>? categories,
    List<FeaturedProducts>? featuredProducts,
    List<Cuisines>? cuisines,
    List<Restaurants>? restaurants,
    List<FeaturedProducts>? newArrivalProducts,
  }) {
    return HomeModel(
      categories: categories ?? this.categories,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      cuisines: cuisines ?? this.cuisines,
      restaurants: restaurants ?? this.restaurants,
      newArrivalProducts: newArrivalProducts ?? this.newArrivalProducts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': categories!.map((x) => x.toMap()).toList(),
      'featured_products': featuredProducts!.map((x) => x.toMap()).toList(),
      'cuisines': cuisines!.map((x) => x.toMap()).toList(),
      'restaurants': restaurants!.map((x) => x.toMap()).toList(),
      'new_arrival_products': newArrivalProducts!.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      categories: map['categories'] != null ? List<Categories>.from((map['categories'] as List<dynamic>).map<Categories?>((x) => Categories.fromMap(x as Map<String,dynamic>),),) : null,
      featuredProducts: map['featured_products'] != null ? List<FeaturedProducts>.from((map['featured_products'] as List<dynamic>).map<FeaturedProducts?>((x) => FeaturedProducts.fromMap(x as Map<String,dynamic>),),) : null,
      cuisines: map['cuisines'] != null ? List<Cuisines>.from((map['cuisines'] as List<dynamic>).map<Cuisines?>((x) => Cuisines.fromMap(x as Map<String,dynamic>),),) : null,
      restaurants: map['restaurants'] != null ? List<Restaurants>.from((map['restaurants'] as List<dynamic>).map<Restaurants?>((x) => Restaurants.fromMap(x as Map<String,dynamic>),),) : null,
      newArrivalProducts: map['new_arrival_products'] != null ? List<FeaturedProducts>.from((map['new_arrival_products'] as List<dynamic>).map<FeaturedProducts?>((x) => FeaturedProducts.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) => HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      categories,
      featuredProducts,
      cuisines,
      restaurants,
      newArrivalProducts,
    ];
  }
}

