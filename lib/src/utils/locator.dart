import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:puntos_colombia_short_url/src/data/datasources/local/app_database.dart';
import 'package:puntos_colombia_short_url/src/data/datasources/remote/clean_uri_api_service.dart';
import 'package:puntos_colombia_short_url/src/data/repositories/clean_uri_api_repository_impl.dart';
import 'package:puntos_colombia_short_url/src/data/repositories/database_repository_impl.dart';
import 'package:puntos_colombia_short_url/src/domain/models/repositories/clean_uri_api_repository.dart';
import 'package:puntos_colombia_short_url/src/domain/models/repositories/database_repository.dart';
import 'package:puntos_colombia_short_url/src/utils/constants/strings.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
  locator.registerSingleton<AppDatabase>(db);

  locator.registerSingleton<DatabaseRepository>(
    DatabaseRepositoryImpl(locator<AppDatabase>()),
  );

  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<CleanUriApiService>(
      CleanUriApiService(locator<Dio>()));
  locator.registerSingleton<CleanUriApiRepository>(
      CleanUriApiRepositoryImpl(locator<CleanUriApiService>()));
}
