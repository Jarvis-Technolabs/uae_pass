import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:uae_pass/src/core/di/prod_di_getter.dart';
import 'package:uae_pass/src/core/util/common_utilities.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/datasource/uae_pass_data_source.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/datasource/uae_pass_data_source_impl.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/domain/uae_pass_repo.dart';

import '../api/data_source/network_info/network_info.dart';
import '../api/data_source/network_info/network_info_impl.dart';
import '../api/data_source/remote_ds/remote_ds.dart';
import '../api/data_source/remote_ds/remote_ds_impl.dart';
import '../api/interceptor/api_call_log_printer_interceptor.dart';
import '../loggers/app_log_filter.dart';
import '../loggers/app_log_printer.dart';
import '../loggers/log_to_file.dart';
import 'di_getter.dart';
import 'mock_di_getter.dart';

///Service locator
final sl = GetIt.instance;

/// change as per requirements of mock data/prod data
const choice = Choice.PROD_DATA;

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

  ///Dio and interceptors
  Dio dio = Dio();
  dio.interceptors.add(ApiCallLogPrinterInterceptors());
  sl.registerSingleton<Dio>(dio);

  ///UAE Pass
  sl.registerLazySingleton<UaePassRepo>(() => getter.getUaePassRepo());

  sl.registerLazySingleton<UaePassDataSource>(
    () => UaePassDataSourceImpl(
      remoteDataSource: sl(),
    ),
  );
}
