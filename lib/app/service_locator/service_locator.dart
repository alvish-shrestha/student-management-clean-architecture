import 'package:get_it/get_it.dart';
import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:student_management/features/batch/data/data_source/local_datasource/batch_local_data_source.dart';
import 'package:student_management/features/batch/data/repository/local_repository/batch_local_repository.dart';
import 'package:student_management/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_bloc.dart';
import 'package:student_management/features/course/data/data_source/local_datasource/course_local_data_source.dart';
import 'package:student_management/features/course/data/repository/local_repository/course_local_repository.dart';
import 'package:student_management/features/course/domain/use_case/create_course_usecase.dart';
import 'package:student_management/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:student_management/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_bloc.dart';
import 'package:student_management/features/home/presentation/view_model/home_view_model.dart';
import 'package:student_management/features/splash/presentation/view_model/splash_view_model.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initHiveService();
  await _initCourseModule();
  await _initBatchModule();
  await _initHomeModule();
  await _initAuthModule();
  await _initSplashModule();
}

Future _initHiveService() async {
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
}

Future _initCourseModule() async {
  serviceLocator.registerFactory<CourseLocalDataSource>(
    () => CourseLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );

  serviceLocator.registerLazySingleton<CourseLocalRepository>(
    () => CourseLocalRepository(
      courseLocalDataSource: serviceLocator<CourseLocalDataSource>(),
    ),
  );

  serviceLocator.registerLazySingleton<CreateCourseUsecase>(
    () => CreateCourseUsecase(
      courseRepository: serviceLocator<CourseLocalRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton<GetAllCourseUsecase>(
    () => GetAllCourseUsecase(
      courseRepository: serviceLocator<CourseLocalRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton<DeleteCourseUseCase>(
    () => DeleteCourseUseCase(
      courseRepository: serviceLocator<CourseLocalRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => CourseViewBloc(
      createCourseUseCase: serviceLocator<CreateCourseUsecase>(),
      getAllCourseUseCase: serviceLocator<GetAllCourseUsecase>(),
      deleteCourseUseCase: serviceLocator<DeleteCourseUseCase>(),
    ),
  );
}

Future _initBatchModule() async {
  serviceLocator.registerFactory<BatchLocalDataSource>(
    () => BatchLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );

  serviceLocator.registerLazySingleton<BatchLocalRepository>(
    () => BatchLocalRepository(
      batchLocalDataSource: serviceLocator<BatchLocalDataSource>(),
    ),
  );

  serviceLocator.registerLazySingleton<CreateBatchUsecase>(
    () => CreateBatchUsecase(
      batchRepository: serviceLocator<BatchLocalRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton<GetAllBatchUsecase>(
    () => GetAllBatchUsecase(
      batchRepository: serviceLocator<BatchLocalRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton<DeleteBatchUseCase>(
    () => DeleteBatchUseCase(
      batchRepository: serviceLocator<BatchLocalRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => BatchViewBloc(
      createBatchUseCase: serviceLocator<CreateBatchUsecase>(),
      getAllBatchUseCase: serviceLocator<GetAllBatchUsecase>(),
      deleteBatchUseCase: serviceLocator<DeleteBatchUseCase>(),
    ),
  );
}

Future _initHomeModule() async {
  serviceLocator.registerLazySingleton(() => HomeViewModel());
}

Future _initAuthModule() async {
  serviceLocator.registerFactory(() => LoginViewModel());
  serviceLocator.registerFactory(() => RegisterViewModel());
}

Future _initSplashModule() async {
  serviceLocator.registerFactory(() => SplashViewModel());
}
