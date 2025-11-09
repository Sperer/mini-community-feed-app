import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mini_community_feed_app/core/network/api_client.dart';
import 'package:mini_community_feed_app/core/network/network_info.dart';
import 'package:mini_community_feed_app/feature/data/data_sources/get_post_remote_data_source.dart';
import 'package:mini_community_feed_app/feature/data/data_sources/get_post_remote_data_source_impl.dart';
import 'package:mini_community_feed_app/feature/data/repositories/get_post_repository_impl.dart';
import 'package:mini_community_feed_app/feature/domain/repositories/get_post_repository.dart';
import 'package:mini_community_feed_app/feature/domain/usecases/get_post_usecase.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/post/post_bloc.dart';

final locator = GetIt.instance;

///Function to refister all the instances
void setupLocator() {
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());

  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
  locator.registerLazySingleton(() => ApiClient(locator()));

  locator.registerLazySingleton<GetPostRemoteDataSource>(
      () => GetPostRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<GetPostRepository>(() => GetPostRepositoryImpl(
      getPostRemoteDataSource: locator(), networkInfo: locator()));
  locator.registerLazySingleton(
      () => GetPostUsecase(getPostRepository: locator()));
  locator.registerFactory(() => PostBloc(locator<GetPostUsecase>()));
}
