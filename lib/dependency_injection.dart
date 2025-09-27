import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/AllFood/remote/all_food_remote_data.dart';
import 'package:foodigo/features/AllFood/repository/all_food_repository.dart';
import 'package:foodigo/features/ApplyCoupon/cubit/apply_coupon_cubit.dart';
import 'package:foodigo/features/ApplyCoupon/remote/apply_coupon_remote_data_source.dart';
import 'package:foodigo/features/ApplyCoupon/repository/apply_coupon_repository.dart';
import 'package:foodigo/features/Cart/cubit/cart_cubit.dart';
import 'package:foodigo/features/Cart/remote/cart_remote_data_source.dart';
import 'package:foodigo/features/Cart/repository/cart_repository.dart';
import 'package:foodigo/features/ChangeProfilePass/cubit/change_profile_pass_cubit.dart';
import 'package:foodigo/features/ChangeProfilePass/remote/change_profile_pass_remote_data_source.dart';
import 'package:foodigo/features/ChangeProfilePass/repository/change_profile_pass_repository.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_cubit.dart';
import 'package:foodigo/features/ForgotPassword/remote/forgot_password_remote_data_source.dart';
import 'package:foodigo/features/ForgotPassword/repository/forgot_password_repository.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_cubit.dart';
import 'package:foodigo/features/GetProfile/remote/get_profile_remote_data_source.dart';
import 'package:foodigo/features/GetProfile/repository/get_profile_repository.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Login/remote/login_remote_data.dart';
import 'package:foodigo/features/Login/repository/login_repository.dart';
import 'package:foodigo/features/Order/cubit/order_cubit.dart';
import 'package:foodigo/features/Order/remote/order_remote_data_source.dart';
import 'package:foodigo/features/Order/repository/order_repository.dart';
import 'package:foodigo/features/PaymentMethod/cubit/payment_method_cubit.dart';
import 'package:foodigo/features/PaymentMethod/remote/payment_method_remote_data_source.dart';
import 'package:foodigo/features/PaymentMethod/repository/payment_method_repository.dart';
import 'package:foodigo/features/ProductDetails/cubit/product_details_cubit.dart';
import 'package:foodigo/features/ProductDetails/remote/product_details_remote_data_source.dart';
import 'package:foodigo/features/ProductDetails/repository/product_details_repository.dart';
import 'package:foodigo/features/Review/cubit/review_cubit.dart';
import 'package:foodigo/features/Review/remote/review_remote_data_source.dart';
import 'package:foodigo/features/Review/repository/review_repository.dart';
import 'package:foodigo/features/SingleRestaurant/cubit/single_restaurant_cubit.dart';
import 'package:foodigo/features/SingleRestaurant/remote/single_restaurant_remote_data_source.dart';
import 'package:foodigo/features/SingleRestaurant/repository/single_restaurant_repository.dart';
import 'package:foodigo/features/Splash/cubit/splash_cubit.dart';
import 'package:foodigo/features/Splash/remote/splash_remote_data_source.dart';
import 'package:foodigo/features/Splash/repository/splash_repository.dart';
import 'package:foodigo/features/Subscription/cubit/subscription_cubit.dart';
import 'package:foodigo/features/Subscription/remote/subscription_remote_data_source.dart';
import 'package:foodigo/features/Subscription/repository/subscription_repository.dart';
import 'package:foodigo/features/WishList/cubit/wish_list_cubit.dart';
import 'package:foodigo/features/WishList/remote/wish_list_remote_data_source.dart';
import 'package:foodigo/features/WishList/repository/wish_list_repository.dart';
import 'package:foodigo/features/add_to_cart/cubit/add_cart_cubit.dart';
import 'package:foodigo/features/add_to_cart/remote/add_cart_remote_data_source.dart';
import 'package:foodigo/features/add_to_cart/repository/add_cart_repository.dart';
import 'package:foodigo/features/address/cubit/get_address_cubit.dart';
import 'package:foodigo/features/address/remote/get_address_remote_data_source.dart';
import 'package:foodigo/features/address/repository/get_address_repository.dart';
import 'package:foodigo/features/checkout/cubit/checkout_cubit.dart';
import 'package:foodigo/features/checkout/remote/checkout_remote_data_source.dart';
import 'package:foodigo/features/checkout/repository/checkout_repository.dart';
import 'package:foodigo/features/register/cubit/register_cubit.dart';
import 'package:foodigo/features/register/remote/register_remote_data_source.dart';
import 'package:foodigo/features/register/repository/register_repository.dart';
import 'package:foodigo/features/restaurant_features/Addons/cubit/res_addons_cubit.dart';
import 'package:foodigo/features/restaurant_features/Addons/remote/res_addon_remote_data_source.dart';
import 'package:foodigo/features/restaurant_features/Addons/repository/res_addon_repository.dart';
import 'package:foodigo/features/restaurant_features/Category/cubit/res_categories_cubit.dart';
import 'package:foodigo/features/restaurant_features/Category/remote/res_category_remote_data_source.dart';
import 'package:foodigo/features/restaurant_features/Category/repository/res_category_repository.dart';
import 'package:foodigo/features/restaurant_features/ChangePassword/cubit/res_change_pass_cubit.dart';
import 'package:foodigo/features/restaurant_features/ChangePassword/remote/res_change_pass_remote_data_source.dart';
import 'package:foodigo/features/restaurant_features/ChangePassword/repository/res_change_pass_repository.dart';
import 'package:foodigo/features/restaurant_features/EarningData/cubit/earning_cubit.dart';
import 'package:foodigo/features/restaurant_features/EarningData/remote/earning_remote_data_source.dart';
import 'package:foodigo/features/restaurant_features/EarningData/repository/earning_repository.dart';
import 'package:foodigo/features/restaurant_features/Login/remote/restaurant_login_remote_data.dart';
import 'package:foodigo/features/restaurant_features/Order/cubit/res_order_cubit.dart';
import 'package:foodigo/features/restaurant_features/Order/remote/res_order_remote_data_source.dart';
import 'package:foodigo/features/restaurant_features/Order/repository/res_order_repository.dart';
import 'package:foodigo/features/restaurant_features/Products/cubit/product_cubit.dart';
import 'package:foodigo/features/restaurant_features/Products/remote/product_remote_data_source.dart';
import 'package:foodigo/features/restaurant_features/Products/repository/product_repository.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/cubit/res_dashboard_cubit.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/repository/res_dashboard_repository.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_cubit.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/remote/restaurant_profile_remote_data_source.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/repository/restaurant_profile_repository.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/remote/store_product_remote_data_source.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/repository/store_product_repository.dart';
import 'package:foodigo/features/restaurant_features/WithdrawData/cubit/withdraw_cubit.dart';
import 'package:foodigo/features/restaurant_features/WithdrawData/remote/withdraw_remote_data_source.dart';
import 'package:foodigo/features/restaurant_features/WithdrawData/repository/withdraw_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/local_data_source.dart';
import 'features/AllFood/cubit/all_food_cubit.dart';
import 'features/AllRestaurant/cubit/all_restaurant_cubit.dart';
import 'features/AllRestaurant/remote/all_restaurant_remote_data_source.dart';
import 'features/AllRestaurant/repository/all_restaurant_repository.dart';
import 'features/HomeData/cubit/home_data_cubit.dart';
import 'features/HomeData/remote/home_data_remote_data_source.dart';
import 'features/HomeData/repository/home_data_repository.dart';
import 'features/restaurant_features/Login/bloc/restaurant_login_bloc.dart';
import 'features/restaurant_features/Login/repository/restaurant_login_repository.dart';
import 'features/restaurant_features/RestaurantDashboard/remote/res_dashboard_remote_data_source.dart';

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
    RepositoryProvider<RestaurantLoginRemoteData>(
      create: (context) => RestaurantLoginRemoteDataImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<RestaurantLoginRepository>(
      create: (context) => RestaurantLoginRepositoryImpl(
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
    RepositoryProvider<CheckoutRemoteDataSource>(
      create: (context) => CheckoutRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<CheckoutRepository>(
      create: (context) => CheckoutRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<OrderRemoteDataSource>(
      create: (context) => OrderRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<OrderRepository>(
      create: (context) => OrderRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<WishListRemoteDataSource>(
      create: (context) => WishListRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<WishListRepository>(
      create: (context) => WishListRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ReviewRemoteDataSource>(
      create: (context) => ReviewRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<ReviewRepository>(
      create: (context) => ReviewRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<AllFoodRemoteDataSource>(
      create: (context) => AllFoodRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<AllFoodRepository>(
      create: (context) => AllFoodRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<RegisterRemoteDataSource>(
      create: (context) => RegisterRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<RegisterRepository>(
      create: (context) => RegisterRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ForgotPasswordRemoteDataSource>(
      create: (context) => ForgotPasswordRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<ForgotPasswordRepository>(
      create: (context) => ForgotPasswordRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ApplyCouponRemoteDataSource>(
      create: (context) => ApplyCouponRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<ApplyCouponRepository>(
      create: (context) => ApplyCouponRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<PaymentMethodRemoteDataSource>(
      create: (context) => PaymentMethodRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<PaymentMethodRepository>(
      create: (context) => PaymentMethodRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ChangeProfilePassRemoteDataSource>(
      create: (context) => ChangeProfilePassRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<ChangeProfilePassRepository>(
      create: (context) => ChangeProfilePassRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<SubscriptionRemoteDataSource>(
      create: (context) => SubscriptionRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<SubscriptionRepository>(
      create: (context) => SubscriptionRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ResDashboardRemoteDataSource>(
      create: (context) => ResDashboardRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<ResDashboardRepository>(
      create: (context) => ResDashboardRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ProductRemoteDataSource>(
      create: (context) => ProductRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<ProductRepository>(
      create: (context) => ProductRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ResOrderRemoteDataSource>(
      create: (context) => ResOrderRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<ResOrderRepository>(
      create: (context) => ResOrderRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ResCategoryRemoteDataSource>(
      create: (context) => ResCategoryRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<ResCategoryRepository>(
      create: (context) => ResCategoryRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<StoreProductRemoteDataSource>(
      create: (context) => StoreProductRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<StoreProductRepository>(
      create: (context) => StoreProductRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<RestaurantProfileRemoteDataSource>(
      create: (context) => RestaurantProfileRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<RestaurantProfileRepository>(
      create: (context) => RestaurantProfileRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ResAddonRemoteDataSource>(
      create: (context) => ResAddonRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<ResAddonRepository>(
      create: (context) => ResAddonRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ResChangePassRemoteDataSource>(
      create: (context) => ResChangePassRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<ResChangePassRepository>(
      create: (context) => ResChangePassRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<EarningRemoteDataSource>(
      create: (context) => EarningRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<EarningRepository>(
      create: (context) => EarningRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<WithdrawRemoteDataSource>(
      create: (context) => WithdrawRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<WithdrawRepository>(
      create: (context) => WithdrawRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<SplashRemoteDataSource>(
      create: (context) => SplashRemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<SplashRepository>(
      create: (context) => SplashRepositoryImpl(
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
    BlocProvider<RestaurantLoginBloc>(
      create: (context) => RestaurantLoginBloc(
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
    BlocProvider<CheckoutCubit>(
      create: (context) => CheckoutCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<OrderCubit>(
      create: (context) => OrderCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<WishListCubit>(
      create: (context) => WishListCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ReviewCubit>(
      create: (context) => ReviewCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<AllFoodCubit>(
      create: (context) => AllFoodCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(
        registerRepository: context.read(),
      ),
    ),
    BlocProvider<ForgotPasswordCubit>(
      create: (context) => ForgotPasswordCubit(
        forgotPasswordRepository: context.read(),
      ),
    ),
    BlocProvider<ApplyCouponCubit>(
      create: (context) => ApplyCouponCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<PaymentCubit>(
      create: (context) => PaymentCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ChangeProfilePassCubit>(
      create: (context) => ChangeProfilePassCubit(
        registerRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<SubscriptionCubit>(
      create: (context) => SubscriptionCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ResDashboardCubit>(
      create: (context) => ResDashboardCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ProductCubit>(
      create: (context) => ProductCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ResOrderCubit>(
      create: (context) => ResOrderCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ResCategoriesCubit>(
      create: (context) => ResCategoriesCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<StoreProductCubit>(
      create: (context) => StoreProductCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<RestaurantProfileCubit>(
      create: (context) => RestaurantProfileCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ResAddonsCubit>(
      create: (context) => ResAddonsCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ResChangePassCubit>(
      create: (context) => ResChangePassCubit(
        registerRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<EarningCubit>(
      create: (context) => EarningCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<WithdrawCubit>(
      create: (context) => WithdrawCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
  ];
}
