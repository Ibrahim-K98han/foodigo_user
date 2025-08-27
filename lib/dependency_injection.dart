import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/AllRestaurant/remote/all_restaurant_remote_data_source.dart';
import 'package:foodigo/features/Cart/cubit/cart_cubit.dart';
import 'package:foodigo/features/Cart/remote/cart_remote_data_source.dart';
import 'package:foodigo/features/Cart/repository/cart_repository.dart';
import 'package:foodigo/features/SingleRestaurant/cubit/single_restaurant_cubit.dart';
import 'package:foodigo/features/SingleRestaurant/remote/single_restaurant_remote_data_source.dart';
import 'package:foodigo/features/SingleRestaurant/repository/single_restaurant_repository.dart';
import 'package:http/http.dart';
import 'features/AllRestaurant/cubit/all_restaurant_cubit.dart';
import 'features/AllRestaurant/repository/all_restaurant_repository.dart';
import 'features/HomeData/cubit/home_data_cubit.dart';
import 'features/HomeData/remote/home_data_remote_data_source.dart';
import 'features/HomeData/repository/home_data_repository.dart';

class DInjector {
  static final repositoryProvider = <RepositoryProvider>[
    RepositoryProvider<Client>(
      create: (context) => Client(),
    ),
    RepositoryProvider<HomeDataRemoteDataSource>(
      create: (context) => HomeDataRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<HomeDataRepository>(
      create: (context) => HomeDataRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<AllRestaurantRemoteDataSource>(
      create: (context) => AllRestaurantRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<AllRestaurantRepository>(
      create: (context) => AllRestaurantRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<SingleRestaurantRemoteDataSource>(
      create: (context) => SingleRestaurantRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<SingleRestaurantRepository>(
      create: (context) => SingleRestaurantRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<CartRemoteDataSource>(
      create: (context) => CartRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<CartRepository>(
      create: (context) => CartRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
  ];

  static final blocProvider = <BlocProvider>[
    BlocProvider<HomeDataCubit>(
      create: (context) => HomeDataCubit(
        repository: context.read(),
      ),
    ),
    BlocProvider<AllRestaurantCubit>(
      create: (context) => AllRestaurantCubit(
        repository: context.read(),
      ),
    ),
    BlocProvider<SingleRestaurantCubit>(
      create: (context) => SingleRestaurantCubit(
        repository: context.read(),
      ),
    ),
    BlocProvider<CartCubit>(
      create: (context) => CartCubit(
        repository: context.read(),
      ),
    ),
  ];
}
