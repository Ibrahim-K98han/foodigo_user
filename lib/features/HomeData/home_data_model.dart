// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:foodigo/features/HomeData/category_model.dart';
import 'package:foodigo/features/HomeData/cuisines_model.dart';
import 'package:foodigo/features/HomeData/feature_product_model.dart';
import 'package:foodigo/features/HomeData/restaurant_model.dart';

class HomeModel extends Equatable {
  final HomePage? homePage;
  final List<Categories>? categories;
  final List<FeaturedProducts>? featuredProducts;
  final List<Cuisines>? cuisines;
  final List<Restaurants>? restaurants;
  final List<FeaturedProducts>? newArrivalProducts;

  const HomeModel({
    this.homePage,
    this.categories,
    this.featuredProducts,
    this.cuisines,
    this.restaurants,
    this.newArrivalProducts,
  });

  HomeModel copyWith({
    HomePage? homePage,
    List<Categories>? categories,
    List<FeaturedProducts>? featuredProducts,
    List<Cuisines>? cuisines,
    List<Restaurants>? restaurants,
    List<FeaturedProducts>? newArrivalProducts,
  }) {
    return HomeModel(
      homePage: homePage ?? this.homePage,
      categories: categories ?? this.categories,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      cuisines: cuisines ?? this.cuisines,
      restaurants: restaurants ?? this.restaurants,
      newArrivalProducts: newArrivalProducts ?? this.newArrivalProducts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'homepage': homePage?.toMap(),
      'categories': categories?.map((x) => x.toMap()).toList(),
      'featured_products': featuredProducts?.map((x) => x.toMap()).toList(),
      'cuisines': cuisines?.map((x) => x.toMap()).toList(),
      'restaurants': restaurants?.map((x) => x.toMap()).toList(),
      'new_arrival_products':
          newArrivalProducts?.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      homePage:
          map['homepage'] != null
              ? HomePage.fromMap(map['homepage'] as Map<String, dynamic>)
              : null,
      categories:
          (map['categories'] as List<dynamic>?)
              ?.map((x) => Categories.fromMap(x as Map<String, dynamic>))
              .toList(),
      featuredProducts:
          (map['featured_products'] as List<dynamic>?)
              ?.map((x) => FeaturedProducts.fromMap(x as Map<String, dynamic>))
              .toList(),
      cuisines:
          (map['cuisines'] as List<dynamic>?)
              ?.map((x) => Cuisines.fromMap(x as Map<String, dynamic>))
              .toList(),
      restaurants:
          (map['restaurants'] as List<dynamic>?)
              ?.map((x) => Restaurants.fromMap(x as Map<String, dynamic>))
              .toList(),
      newArrivalProducts:
          (map['new_arrival_products'] as List<dynamic>?)
              ?.map((x) => FeaturedProducts.fromMap(x as Map<String, dynamic>))
              .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      homePage,
      categories,
      featuredProducts,
      cuisines,
      restaurants,
      newArrivalProducts,
    ];
  }
}

class HomePage extends Equatable {
  final int id;
  final String introBannerOne;
  final String introBannerTwo;
  final String joinRestaurantImage;
  final String mobileAppImage;
  final String workingStepIcon1;
  final String workingStepIcon2;
  final String workingStepIcon3;
  final String workingStepIcon4;
  final String createdAt;
  final String updatedAt;
  final String mobilePlaystore;
  final String mobileAppstore;
  final String footerImgOne;
  final String footerImgTwo;
  final String footerImgThree;
  final String footerImgFour;
  final String footerImgOneLink;
  final String footerImgTwoLink;
  final String footerImgThreeLink;
  final String footerImgFourLink;
  final String footerImgFive;
  final String footerImgFiveLink;
  final String footerImgSix;
  final String footerImgSixLink;
  final String promotionalBannerOne;
  final String promotionalBannerOneStatus;
  final String promotionalBannerOneUrl;
  final String promotionalBannerTwo;
  final String promotionalBannerTwoStatus;
  final String promotionalBannerTwoUrl;
  final String promotionalBannerRestaurant;
  final String promotionalBannerRestaurantStatus;
  final String promotionalBannerRestaurantUrl;
  final String blogBannerOne;
  final String blogBannerOneLink;
  final String blogBannerOneStatus;
  final String blogBannerTwo;
  final String blogBannerTwoLink;
  final String blogBannerTwoStatus;

  const HomePage({
    required this.id,
    required this.introBannerOne,
    required this.introBannerTwo,
    required this.joinRestaurantImage,
    required this.mobileAppImage,
    required this.workingStepIcon1,
    required this.workingStepIcon2,
    required this.workingStepIcon3,
    required this.workingStepIcon4,
    required this.createdAt,
    required this.updatedAt,
    required this.mobilePlaystore,
    required this.mobileAppstore,
    required this.footerImgOne,
    required this.footerImgTwo,
    required this.footerImgThree,
    required this.footerImgFour,
    required this.footerImgOneLink,
    required this.footerImgTwoLink,
    required this.footerImgThreeLink,
    required this.footerImgFourLink,
    required this.footerImgFive,
    required this.footerImgFiveLink,
    required this.footerImgSix,
    required this.footerImgSixLink,
    required this.promotionalBannerOne,
    required this.promotionalBannerOneStatus,
    required this.promotionalBannerOneUrl,
    required this.promotionalBannerTwo,
    required this.promotionalBannerTwoStatus,
    required this.promotionalBannerTwoUrl,
    required this.promotionalBannerRestaurant,
    required this.promotionalBannerRestaurantStatus,
    required this.promotionalBannerRestaurantUrl,
    required this.blogBannerOne,
    required this.blogBannerOneLink,
    required this.blogBannerOneStatus,
    required this.blogBannerTwo,
    required this.blogBannerTwoLink,
    required this.blogBannerTwoStatus,
  });

  HomePage copyWith({
    int? id,
    String? introBannerOne,
    String? introBannerTwo,
    String? joinRestaurantImage,
    String? mobileAppImage,
    String? workingStepIcon1,
    String? workingStepIcon2,
    String? workingStepIcon3,
    String? workingStepIcon4,
    String? createdAt,
    String? updatedAt,
    String? mobilePlaystore,
    String? mobileAppstore,
    String? footerImgOne,
    String? footerImgTwo,
    String? footerImgThree,
    String? footerImgFour,
    String? footerImgOneLink,
    String? footerImgTwoLink,
    String? footerImgThreeLink,
    String? footerImgFourLink,
    String? footerImgFive,
    String? footerImgFiveLink,
    String? footerImgSix,
    String? footerImgSixLink,
    String? promotionalBannerOne,
    String? promotionalBannerOneStatus,
    String? promotionalBannerOneUrl,
    String? promotionalBannerTwo,
    String? promotionalBannerTwoStatus,
    String? promotionalBannerTwoUrl,
    String? promotionalBannerRestaurant,
    String? promotionalBannerRestaurantStatus,
    String? promotionalBannerRestaurantUrl,
    String? blogBannerOne,
    String? blogBannerOneLink,
    String? blogBannerOneStatus,
    String? blogBannerTwo,
    String? blogBannerTwoLink,
    String? blogBannerTwoStatus,
  }) {
    return HomePage(
      id: id ?? this.id,
      introBannerOne: introBannerOne ?? this.introBannerOne,
      introBannerTwo: introBannerTwo ?? this.introBannerTwo,
      joinRestaurantImage: joinRestaurantImage ?? this.joinRestaurantImage,
      mobileAppImage: mobileAppImage ?? this.mobileAppImage,
      workingStepIcon1: workingStepIcon1 ?? this.workingStepIcon1,
      workingStepIcon2: workingStepIcon2 ?? this.workingStepIcon2,
      workingStepIcon3: workingStepIcon3 ?? this.workingStepIcon3,
      workingStepIcon4: workingStepIcon4 ?? this.workingStepIcon4,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      mobilePlaystore: mobilePlaystore ?? this.mobilePlaystore,
      mobileAppstore: mobileAppstore ?? this.mobileAppstore,
      footerImgOne: footerImgOne ?? this.footerImgOne,
      footerImgTwo: footerImgTwo ?? this.footerImgTwo,
      footerImgThree: footerImgThree ?? this.footerImgThree,
      footerImgFour: footerImgFour ?? this.footerImgFour,
      footerImgOneLink: footerImgOneLink ?? this.footerImgOneLink,
      footerImgTwoLink: footerImgTwoLink ?? this.footerImgTwoLink,
      footerImgThreeLink: footerImgThreeLink ?? this.footerImgThreeLink,
      footerImgFourLink: footerImgFourLink ?? this.footerImgFourLink,
      footerImgFive: footerImgFive ?? this.footerImgFive,
      footerImgFiveLink: footerImgFiveLink ?? this.footerImgFiveLink,
      footerImgSix: footerImgSix ?? this.footerImgSix,
      footerImgSixLink: footerImgSixLink ?? this.footerImgSixLink,
      promotionalBannerOne: promotionalBannerOne ?? this.promotionalBannerOne,
      promotionalBannerOneStatus:
          promotionalBannerOneStatus ?? this.promotionalBannerOneStatus,
      promotionalBannerOneUrl:
          promotionalBannerOneUrl ?? this.promotionalBannerOneUrl,
      promotionalBannerTwo: promotionalBannerTwo ?? this.promotionalBannerTwo,
      promotionalBannerTwoStatus:
          promotionalBannerTwoStatus ?? this.promotionalBannerTwoStatus,
      promotionalBannerTwoUrl:
          promotionalBannerTwoUrl ?? this.promotionalBannerTwoUrl,
      promotionalBannerRestaurant:
          promotionalBannerRestaurant ?? this.promotionalBannerRestaurant,
      promotionalBannerRestaurantStatus:
          promotionalBannerRestaurantStatus ??
          this.promotionalBannerRestaurantStatus,
      promotionalBannerRestaurantUrl:
          promotionalBannerRestaurantUrl ?? this.promotionalBannerRestaurantUrl,
      blogBannerOne: blogBannerOne ?? this.blogBannerOne,
      blogBannerOneLink: blogBannerOneLink ?? this.blogBannerOneLink,
      blogBannerOneStatus: blogBannerOneStatus ?? this.blogBannerOneStatus,
      blogBannerTwo: blogBannerTwo ?? this.blogBannerTwo,
      blogBannerTwoLink: blogBannerTwoLink ?? this.blogBannerTwoLink,
      blogBannerTwoStatus: blogBannerTwoStatus ?? this.blogBannerTwoStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'intro_banner_one': introBannerOne,
      'intro_banner_two': introBannerTwo,
      'join_restaurant_image': joinRestaurantImage,
      'mobile_app_image': mobileAppImage,
      'working_step_icon1': workingStepIcon1,
      'working_step_icon2': workingStepIcon2,
      'working_step_icon3': workingStepIcon3,
      'working_step_icon4': workingStepIcon4,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'mobile_playstore': mobilePlaystore,
      'mobile_appstore': mobileAppstore,
      'footer_img_one': footerImgOne,
      'footer_img_two': footerImgTwo,
      'footer_img_three': footerImgThree,
      'footer_img_four': footerImgFour,
      'footer_img_one_link': footerImgOneLink,
      'footer_img_two_link': footerImgTwoLink,
      'footer_img_three_link': footerImgThreeLink,
      'footer_img_four_link': footerImgFourLink,
      'footer_img_five': footerImgFive,
      'footer_img_five_link': footerImgFiveLink,
      'footer_img_six': footerImgSix,
      'footer_img_six_link': footerImgSixLink,
      'promotional_banner_one': promotionalBannerOne,
      'promotional_banner_one_status': promotionalBannerOneStatus,
      'promotional_banner_one_url': promotionalBannerOneUrl,
      'promotional_banner_two': promotionalBannerTwo,
      'promotional_banner_two_status': promotionalBannerTwoStatus,
      'promotional_banner_two_url': promotionalBannerTwoUrl,
      'promotional_banner_restaurant': promotionalBannerRestaurant,
      'promotional_banner_restaurant_status': promotionalBannerRestaurantStatus,
      'promotional_banner_restaurant_url': promotionalBannerRestaurantUrl,
      'blog_banner_one': blogBannerOne,
      'blog_banner_one_link': blogBannerOneLink,
      'blog_banner_one_status': blogBannerOneStatus,
      'blog_banner_two': blogBannerTwo,
      'blog_banner_two_link': blogBannerTwoLink,
      'blog_banner_two_status': blogBannerTwoStatus,
    };
  }

  factory HomePage.fromMap(Map<String, dynamic> map) {
    return HomePage(
      id: map['id'] ?? 0,
      introBannerOne: map['intro_banner_one'] ?? '',
      introBannerTwo: map['intro_bnner_two'] ?? '',
      joinRestaurantImage: map['join_restaurant_image'] ?? '',
      mobileAppImage: map['mobile_app_image'] ?? '',
      workingStepIcon1: map['working_step_icon1'] ?? '',
      workingStepIcon2: map['working_step_icon2'] ?? '',
      workingStepIcon3: map['working_step_icon3'] ?? '',
      workingStepIcon4: map['working_step_icon4'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      mobilePlaystore: map['mobile_playstore'] ?? '',
      mobileAppstore: map['mobile_appstore'] ?? '',
      footerImgOne: map['footer_img_one'] ?? '',
      footerImgTwo: map['footer_img_two'] ?? '',
      footerImgThree: map['footer_img_three'] ?? '',
      footerImgFour: map['footer_img_four'] ?? '',
      footerImgOneLink: map['footer_img_one_link'] ?? '',
      footerImgTwoLink: map['footer_img_two_link'] ?? '',
      footerImgThreeLink: map['footer_img_three_link'] ?? '',
      footerImgFourLink: map['footer_img_four_link'] ?? '',
      footerImgFive: map['footer_img_five'] ?? '',
      footerImgFiveLink: map['footer_img_five_link'] ?? '',
      footerImgSix: map['footer_img_six'] ?? '',
      footerImgSixLink: map['footer_img_six_link'] ?? '',
      promotionalBannerOne: map['promotional_banner_one'] ?? '',
      promotionalBannerOneStatus: map['promotional_banner_one_status'] ?? '',
      promotionalBannerOneUrl: map['promotional_banner_one-url'] ?? '',
      promotionalBannerTwo: map['promotional_banner_two'] ?? '',
      promotionalBannerTwoStatus: map['promotional_banner_two_status'] ?? '',
      promotionalBannerTwoUrl: map['promotional_banner_two_url'] ?? '',
      promotionalBannerRestaurant: map['promotional_banner_restaurant'] ?? '',
      promotionalBannerRestaurantStatus:
          map['promotional_banner_restaurant_status'] ?? '',
      promotionalBannerRestaurantUrl:
          map['promotional_banner_restaurant_url'] ?? '',
      blogBannerOne: map['blog_banner_one'] ?? '',
      blogBannerOneLink: map['blog_banner_one_link'] ?? '',
      blogBannerOneStatus: map['blog_banner_one_status'] ?? '',
      blogBannerTwo: map['blog_banner_two'] ?? '',
      blogBannerTwoLink: map['blog_banner_two_link'] ?? '',
      blogBannerTwoStatus: map['blog_banner_two_status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePage.fromJson(String source) =>
      HomePage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      introBannerOne,
      introBannerTwo,
      joinRestaurantImage,
      mobileAppImage,
      workingStepIcon1,
      workingStepIcon2,
      workingStepIcon3,
      workingStepIcon4,
      createdAt,
      updatedAt,
      mobilePlaystore,
      mobileAppstore,
      footerImgOne,
      footerImgTwo,
      footerImgThree,
      footerImgFour,
      footerImgOneLink,
      footerImgTwoLink,
      footerImgThreeLink,
      footerImgFourLink,
      footerImgFive,
      footerImgFiveLink,
      footerImgSix,
      footerImgSixLink,
      promotionalBannerOne,
      promotionalBannerOneStatus,
      promotionalBannerOneUrl,
      promotionalBannerTwo,
      promotionalBannerTwoStatus,
      promotionalBannerTwoUrl,
      promotionalBannerRestaurant,
      promotionalBannerRestaurantStatus,
      promotionalBannerRestaurantUrl,
      blogBannerOne,
      blogBannerOneLink,
      blogBannerOneStatus,
      blogBannerTwo,
      blogBannerTwoLink,
      blogBannerTwoStatus,
    ];
  }
}
