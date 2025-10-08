import 'package:blocsevendays/feature/main/presentation/bloc/bloc_main.dart';
import 'package:blocsevendays/feature/splash/presentation/bloc/bloc_splash.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../feature/main/data/news_remote_datasource.dart';
import '../../feature/splash/data/key_local_datasource.dart';
import '../../feature/splash/data/key_remote_datasource.dart';
import '../../feature/splash/data/key_repository_impl.dart';
import '../../feature/splash/domain/get_key_usecase.dart';
import '../../feature/splash/domain/key_repository.dart';
import '../api/api_client.dart';
import '../api/key_client.dart';

final getIt = GetIt.instance;

class AppModule {
  static void setup() {

    // Core
    getIt.registerSingleton<Dio>(Dio());

    getIt.registerSingleton<ApiClient>(ApiClient(getIt<Dio>()));
    getIt.registerSingleton<KeyClient>(KeyClient(getIt<Dio>()));

    // Data sources
    getIt.registerSingleton<KeyRemoteDataSource>(
      KeyRemoteDataSourceImpl(getIt<KeyClient>()),
    );

    getIt.registerSingleton<KeyLocalDataSource>(
      KeyLocalDataSourceImpl(),
    );

    getIt.registerSingleton<NewsRemoteDataSource>(
      NewsRemoteDataSourceImpl(getIt<ApiClient>()),
    );

    // Repository
    getIt.registerSingleton<KeyRepository>(
      KeyRepositoryImpl(
        getIt<KeyRemoteDataSource>(),
        getIt<KeyLocalDataSource>(),
      ),
    );

    /*getIt.registerSingleton<NewsRepository>(
      NewsRepositoryImpl(
        getIt<NewsRemoteDataSource>(),
      ),
    );*/

    // Use cases
    getIt.registerSingleton<GetKeyUseCase>(
      GetKeyUseCase(getIt<KeyRepository>()),
    );

    /*getIt.registerSingleton<GetNewsUseCase>(
      GetNewsUseCase(getIt<NewsRepository>()),
    );*/


    // BLoC
    getIt.registerFactory<SplashBloc>(
          () => SplashBloc(
        getKeyUseCase: getIt<GetKeyUseCase>(),
      ),
    );

    /*getIt.registerFactory<MainBloc>(
          () => MainBloc(
        getKeyUseCase: getIt<GetNewsUseCase>(),
      ),
    );*/

  }
}