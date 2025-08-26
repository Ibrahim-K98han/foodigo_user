import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

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
  ];

  static final blocProvider = <BlocProvider>[
    BlocProvider<HomeDataCubit>(
      create: (context) => HomeDataCubit(
        repository: context.read(),
      ),
    ),
  ];
}
