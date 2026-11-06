import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import '../features/health/data/datasources/health_remote_datasource.dart';
import '../features/health/data/repositories/health_repository_impl.dart';
import '../features/health/domain/repositories/health_repository.dart';
import '../features/health/domain/usecases/get_health_usecase.dart';
import '../features/health/domain/usecases/ping_usecase.dart';
import '../features/health/presentation/bloc/health_bloc.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator({String? baseUrl}) async {
  // Core Networking
  sl.registerLazySingleton<ApiClient>(() => ApiClient(baseUrl: baseUrl));

  // Feature: Health & Diagnostics
  sl.registerLazySingleton<HealthRemoteDataSource>(
    () => HealthRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton<HealthRepository>(
    () => HealthRepositoryImpl(sl<HealthRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetHealthUseCase>(
    () => GetHealthUseCase(sl<HealthRepository>()),
  );
  sl.registerLazySingleton<PingUseCase>(
    () => PingUseCase(sl<HealthRepository>()),
  );

  // Blocs
  sl.registerFactory<HealthBloc>(
    () => HealthBloc(
      getHealthUseCase: sl<GetHealthUseCase>(),
      pingUseCase: sl<PingUseCase>(),
    ),
  );
}
