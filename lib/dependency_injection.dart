import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Cart/cubit/cart_cubit.dart';
import 'package:foodigo/features/Cart/remote/cart_remote_data_source.dart';
import 'package:foodigo/features/Cart/repository/cart_repository.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_cubit.dart';
import 'package:foodigo/features/GetProfile/remote/get_profile_remote_data_source.dart';
import 'package:foodigo/features/GetProfile/repository/get_profile_repository.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Login/remote/login_remote_data.dart';
import 'package:foodigo/features/Login/repository/login_repository.dart';
import 'package:foodigo/features/ProductDetails/cubit/product_details_cubit.dart';
import 'package:foodigo/features/ProductDetails/remote/product_details_remote_data_source.dart';
import 'package:foodigo/features/ProductDetails/repository/product_details_repository.dart';
import 'package:foodigo/features/SingleRestaurant/cubit/single_restaurant_cubit.dart';
import 'package:foodigo/features/SingleRestaurant/remote/single_restaurant_remote_data_source.dart';
import 'package:foodigo/features/SingleRestaurant/repository/single_restaurant_repository.dart';
import 'package:foodigo/features/add_to_cart/cubit/add_car_cubit.dart';
import 'package:foodigo/features/add_to_cart/remote/add_cart_remote_data_source.dart';
import 'package:foodigo/features/add_to_cart/repository/add_cart_repository.dart';
import 'package:foodigo/features/address/cubit/get_address_cubit.dart';
import 'package:foodigo/features/address/remote/get_address_remote_data_source.dart';
import 'package:foodigo/features/address/repository/get_address_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/local_data_source.dart';
import 'features/AllRestaurant/cubit/all_restaurant_cubit.dart';
import 'features/AllRestaurant/remote/all_restaurant_remote_data_source.dart';
import 'features/AllRestaurant/repository/all_restaurant_repository.dart';
import 'features/HomeData/cubit/home_data_cubit.dart';
import 'features/HomeData/remote/home_data_remote_data_source.dart';
import 'features/HomeData/repository/home_data_repository.dart';

class DInjector {
  static late final SharedPreferences _sharedPreferences;

  static Future<void> initDB() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static final repositoryProvider = <RepositoryProvider>[
    RepositoryProvider<SharedPreferences>(
      create: (context) => _sharedPreferences,
    ),
    RepositoryProvider<Client>(
      create: (context) => Client(),
    ),
    RepositoryProvider<LocalDataSources>(
      create: (context) => LocalDataSourcesImpl(
        sharedPreferences: context.read(),
      ),
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
    RepositoryProvider<ProductDetailsRemoteDataSource>(
      create: (context) => ProductDetailsRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<ProductDetailsRepository>(
      create: (context) => ProductDetailsRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<LoginRemoteDataSource>(
      create: (context) => LoginRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<LoginRepository>(
      create: (context) => LoginRepositoryImpl(
        remoteDataSources: context.read(),
        localDataSources: context.read(),
      ),
    ),
    RepositoryProvider<GetProfileRemoteDataSource>(
      create: (context) => GetProfileRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<GetProfileRepository>(
      create: (context) => GetProfileRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<AddCartRemoteDataSource>(
      create: (context) => AddCartRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<AddCartRepository>(
      create: (context) => AddCartRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<GetAddressRemoteDataSource>(
      create: (context) => GetAddressRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<GetAddressRepository>(
      create: (context) => GetAddressRepositoryImpl(
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
    BlocProvider<ProductDetailsCubit>(
      create: (context) => ProductDetailsCubit(
        repository: context.read(),
      ),
    ),
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        repository: context.read(),
      ),
    ),
    BlocProvider<GetProfileCubit>(
      create: (context) => GetProfileCubit(
          repository: context.read(), loginBloc: context.read()),
    ),
    BlocProvider<CartCubit>(
      create: (context) => CartCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<AddCartCubit>(
      create: (context) => AddCartCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<GetAddressCubit>(
      create: (context) => GetAddressCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
  ];
}
