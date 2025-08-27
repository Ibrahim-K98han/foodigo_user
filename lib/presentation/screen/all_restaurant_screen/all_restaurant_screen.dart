import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/AllRestaurant/cubit/all_restaurant_cubit.dart';
import 'package:foodigo/presentation/screen/home/components/top_restaurant.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import '../../../features/AllRestaurant/cubit/all_restaurant_state.dart';
import '../../../utils/utils.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/loading_widget.dart';
import '../../core/routes/route_names.dart';

class AllRestaurantScreen extends StatefulWidget {
  const AllRestaurantScreen({
    super.key,
  });

  @override
  State<AllRestaurantScreen> createState() => _AllRestaurantScreenState();
}

class _AllRestaurantScreenState extends State<AllRestaurantScreen> {
  late AllRestaurantCubit allRestaurantCubit;

  @override
  void initState() {
    super.initState();
    allRestaurantCubit = context.read<AllRestaurantCubit>();
    allRestaurantCubit.getAllRestaurantData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'All Restaurant'),
      body: BlocConsumer<AllRestaurantCubit, AllRestaurantState>(
        listener: (context, state) {
          if (state is AllRestaurantError) {
            FetchErrorText(text: state.message);
          }
        },
        builder: (context, state) {
          if (state is AllRestaurantLoading) {
            return const LoadingWidget();
          } else if (state is AllRestaurantError) {
            return FetchErrorText(text: state.message);
          } else if (state is AllRestaurantLoaded) {
            final restaurants = state.restaurants;
            return Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 40,
                    offset: Offset(0, 2),
                    spreadRadius: 10,
                  )
                ],
              ),
              child: ListView.builder(
                itemCount: restaurants.length,
                padding: Utils.symmetric(),
                itemBuilder: (BuildContext context, int index) {
                  final res = restaurants[index];
                  return Padding(
                    padding: Utils.only(bottom: 16.0),
                    child: TopRestaurantCart(
                      restaurants: res,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.restaurantProfileScreen,
                          arguments: res.slug,
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}
