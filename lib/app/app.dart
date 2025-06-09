import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/app/service_locator/service_locator.dart';
import 'package:student_management/app/theme/app_theme.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_bloc.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_bloc.dart';
import 'package:student_management/features/splash/presentation/view/splash_view.dart';
import 'package:student_management/features/splash/presentation/view_model/splash_view_model.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashViewModel>(
          create: (_) => serviceLocator<SplashViewModel>(),
        ),
        BlocProvider<BatchViewBloc>(
          create: (_) => BatchViewBloc(
            createBatchUseCase: serviceLocator(),
            getAllBatchUseCase: serviceLocator(),
            deleteBatchUseCase: serviceLocator(),
          ),
        ),
        BlocProvider<CourseViewBloc>(
          create: (_) => CourseViewBloc(
            createCourseUseCase: serviceLocator(),
            getAllCourseUseCase: serviceLocator(),
            deleteCourseUseCase: serviceLocator(),
          ),
        ),
        // Add other blocs here if needed
      ],
      child: MaterialApp(
        title: 'Student Management',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getApplicationTheme(isDarkMode: false),
        home: const SplashView(),
      ),
    );
  }
}
