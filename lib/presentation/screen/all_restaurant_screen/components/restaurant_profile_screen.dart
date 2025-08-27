import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/SingleRestaurant/cubit/single_restaurant_cubit.dart';
import 'package:foodigo/features/SingleRestaurant/cubit/single_restaurant_state.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/presentation/screen/all_restaurant_screen/components/profile_tab_info.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/feedback_dialog.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/primary_button.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';

class RestaurantProfileScreen extends StatefulWidget {
  const RestaurantProfileScreen({super.key, required this.slug});

  final String slug;

  @override
  State<RestaurantProfileScreen> createState() =>
      _RestaurantProfileScreenState();
}

class _RestaurantProfileScreenState extends State<RestaurantProfileScreen> {
  late SingleRestaurantCubit singleRestaurantCubit;

  @override
  void initState() {
    super.initState();
    singleRestaurantCubit = context.read<SingleRestaurantCubit>();
    singleRestaurantCubit.getSingleRestaurantData(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocConsumer<SingleRestaurantCubit, SingleRestaurantState>(
      listener: (context, state) {
        if (state is SingleRestaurantError) {
          FetchErrorText(text: state.message);
        }
      },
      builder: (context, state) {
        if (state is SingleRestaurantLoading) {
          return const LoadingWidget();
        } else if (state is SingleRestaurantError) {
          return FetchErrorText(text: state.message);
        } else if (state is SingleRestaurantLoaded) {
          final restaurant = state.restaurantDetailsModel;
          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomImage(
                    path: RemoteUrls.imageUrl(restaurant.restaurant.coverImage),
                    fit: BoxFit.cover,
                    height: size.height * 0.20,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 45,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_sharp,
                        size: 30,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    right: 20,
                    child: GestureDetector(
                        onTap: () {},
                        child: const CustomImage(
                          path: KImages.loveIcon,
                          color: whiteColor,
                          width: 24,
                          height: 24,
                        )),
                  ),
                  Positioned(
                    bottom: -40,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: CustomImage(
                            path:
                                RemoteUrls.imageUrl(restaurant.restaurant.logo),
                            fit: BoxFit.cover,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    Utils.only(top: 40.0, bottom: 6.0, right: 10.0, left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: restaurant.restaurant.name,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
                        Utils.horizontalSpace(4.0),
                        const CustomImage(path: KImages.rating),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            CustomImage(
                              path: KImages.location,
                              height: 20,
                              color: blackColor.withOpacity(0.4),
                            ),
                            Utils.horizontalSpace(6.0),
                            CustomText(
                              text: restaurant.restaurant.address,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: blackColor.withOpacity(0.4),
                            ),
                          ],
                        ),
                        Utils.horizontalSpace(10.0),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: const BoxDecoration(
                              color: Color(0xFFF98C3B), shape: BoxShape.circle),
                        ),
                        Utils.horizontalSpace(10.0),
                        GestureDetector(
                          onTap: () {
                            _showReviewDialog(context);
                          },
                          child: Row(
                            children: [
                              const CustomImage(path: KImages.star),
                              Utils.horizontalSpace(6.0),
                              Row(
                                children: [
                                  CustomText(
                                    text:
                                        restaurant.restaurant.reviewsAvgRating,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  CustomText(
                                    text:
                                        ' (${restaurant.restaurant.reviewsCount})',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: blackColor.withOpacity(0.4),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Utils.verticalSpace(10.0),
                  ],
                ),
              ),
              Expanded(
                child: RestaurantTabContents(
                  restaurantDetailsModel: restaurant,
                ),
              ),
            ],
          );
        }
        return const Center(child: Text("Something went wrong"));
      },
    ));
  }
}

void _showReviewDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: dialogBgColor,
        // insetPadding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        child: SizedBox(
          width: 400,
          height: 600,
          child: Column(
            children: [
              _dialogHeader(context, 'Reviews'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      _ratingSummary(),
                      const SizedBox(height: 16),
                      _filterChips(),
                      const SizedBox(height: 16),
                      ...List.generate(3, (_) => const ReviewCard()),
                      const SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const CustomText(
                            text: 'See more',
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _dialogHeader(BuildContext context, String? text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    child: Column(
      children: [
        Row(
          children: [
            CustomText(
              text: text ?? '',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
        Row(
          children: [
            const CustomImage(
              path: KImages.rProfile,
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
            const CustomText(
              text: 'Chef’s Place',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            const Spacer(),
            const Icon(Icons.location_on_outlined,
                color: Colors.grey, size: 18),
            GestureDetector(
              onTap: () {
                _showMapDialog(context);
              },
              child: const CustomText(
                text: 'San Jose, Spain',
                fontWeight: FontWeight.w500,
                color: Color(0xFF475569),
              ),
            )
          ],
        )
      ],
    ),
  );
}

void _showMapDialog(BuildContext context) {
  Navigator.of(context).pop();
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: dialogBgColor,
        // insetPadding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        child: SizedBox(
          width: 328,
          height: 380,
          child: Column(
            children: [
              _dialogHeader(context, 'See Location'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Stack(
                        children: [
                          const CustomImage(path: KImages.map),
                          Positioned(
                            bottom: 10,
                            right: 4,
                            left: 4,
                            child: Container(
                              padding: Utils.symmetric(h: 0.0, v: 4.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Icon(Icons.location_on_outlined,
                                        color: Colors.amber, size: 18),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: CustomText(
                                      text: '2972 Westheimer Rd. Santa Ana, ',
                                      fontSize: 12,
                                    ),
                                  ),
                                  Expanded(
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.amber,
                                      child: Icon(
                                        Icons.arrow_forward_sharp,
                                        size: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Utils.verticalSpace(16),
                      PrimaryButton(
                        text: 'Back to home',
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.mainScreen);
                        },
                        fontSize: 14,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _ratingSummary() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CustomText(
              text: '4.9',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            Utils.horizontalSpace(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBar.builder(
                  initialRating: 3,
                  itemSize: 14,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                const CustomText(
                  text: '5000+ ratings',
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 12),
        _ratingBar(5, 0.5),
        _ratingBar(4, 0.2),
        _ratingBar(3, 0.14),
        _ratingBar(2, 0.06),
        _ratingBar(1, 0.1),
      ],
    ),
  );
}

Widget _ratingBar(int star, double percent) {
  return Row(
    children: [
      CustomText(text: '$star'),
      // Text("$star", style: const TextStyle(fontWeight: FontWeight.bold)),
      const Icon(Icons.star, color: Colors.amber, size: 14),
      const SizedBox(width: 6),
      Expanded(
        child: LinearProgressIndicator(
          value: percent,
          backgroundColor: Colors.grey.shade200,
          color: Colors.amber,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      const SizedBox(width: 8),
      CustomText(text: "${(percent * 100).toInt()}%")
    ],
  );
}

Widget _filterChips() {
  return Row(
    children: [
      _filterButton("Newest", selected: true),
      const SizedBox(width: 8),
      _filterButton("Highest Rating"),
    ],
  );
}

Widget _filterButton(String text, {bool selected = false}) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: selected ? Colors.amber : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(text: text));
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("Dialog Test")),
    body: Center(
      child: ElevatedButton(
        onPressed: () => _showReviewDialog(context),
        child: const Text("Show Review Dialog"),
      ),
    ),
  );
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                child: CustomImage(path: KImages.profile),
              ),
              SizedBox(width: 8),
              CustomText(
                text: 'Brain Loon',
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Row(
                  children: List.generate(
                      5,
                      (_) => const Icon(Icons.star,
                          color: Colors.amber, size: 18))),
              Utils.horizontalSpace(4),
              const CustomText(
                text: '2 days ago',
                color: Color(0xff64748B),
              )
            ],
          ),
          const SizedBox(height: 6),
          const CustomText(
            text: "“Wow tasty, really enjoy it”",
          ),
          const SizedBox(height: 6),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              CustomText(
                text: 'Helpful',
                color: Color(0xff64748B),
              ),
            ],
          )
        ],
      ),
    );
  }
}
