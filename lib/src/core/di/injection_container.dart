import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:uae_pass/src/core/di/prod_di_getter.dart';
import 'package:uae_pass/src/core/util/common_utilities.dart';

import '../api/data_source/network_info/network_info.dart';
import '../api/data_source/network_info/network_info_impl.dart';
import '../api/data_source/remote_ds/remote_ds.dart';
import '../api/data_source/remote_ds/remote_ds_impl.dart';
import '../api/interceptor/api_call_log_printer_interceptor.dart';
import '../api/interceptor/dio_api_cache_interceptor.dart';
import '../const/api_cache_constants.dart';
import '../device_info/repository/device_info_data_source.dart';
import '../device_info/repository/device_info_data_source_impl.dart';
import '../loggers/app_log_filter.dart';
import '../loggers/app_log_printer.dart';
import '../loggers/log_to_file.dart';
import '../util/file_path_util/file_paths.dart';
import 'di_getter.dart';
import 'mock_di_getter.dart';

///Service locator
final sl = GetIt.instance;

/// change as per requirements of mock data/prod data
const choice = Choice.MOCK_DATA;

///init
Future<void> init() async {
  /// Dependency Injector
  DIGetter getter =
      choice == Choice.MOCK_DATA ? MockDIGetter() : ProdDIGetter();

  ///Logger
  sl.registerLazySingleton<Logger>(
    () => Logger(
      filter: AppLogFilter(),
      printer: AppLogPrinter(
        loggerFileUtil: sl(),
      ),
    ),
  );
  sl.registerLazySingleton<LoggerFileUtil>(() => LoggerFileUtil());

  ///CommonUtilities
  sl.registerLazySingleton<CommonUtilities>(() => CommonUtilities());

  ///Internet Connection checking
  sl.registerLazySingleton(() => Connectivity());

  ///Network
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///API calling repo
  sl.registerLazySingleton<IRemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));

  ///API cache
  HiveCacheStore cacheStore = HiveCacheStore(
    await FilePaths().getTemporaryFileDirectory(),
    hiveBoxName: HIVE_CACHE_BOX_NAME,
  );
  sl.registerSingleton<HiveCacheStore>(cacheStore);

  ///Dio and interceptors
  Dio dio = Dio();
  dio.interceptors.add(ApiCallLogPrinterInterceptors());
  dio.interceptors.add(DioAPICacheInterceptor(hiveCacheStore: cacheStore));
  sl.registerSingleton<Dio>(dio);

  ///Device information
  sl.registerLazySingleton<DeviceInfoDataSource>(
    () => DeviceInfoDataSourceImpl(),
  );
}
