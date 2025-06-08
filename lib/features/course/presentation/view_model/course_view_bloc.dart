import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/course/domain/use_case/create_course_usecase.dart';
import 'package:student_management/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:student_management/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_event.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_state.dart';

class CourseViewBloc extends Bloc<CourseViewEvent, CourseViewState> {
  final CreateCourseUsecase _createCourseUsecase;
  final GetAllCourseUsecase _getAllCourseUsecase;
  final DeleteCourseUseCase _deleteCourseUseCase;

  CourseViewBloc({
    required CreateCourseUsecase createCourseUseCase,
    required GetAllCourseUsecase getAllCourseUseCase,
    required DeleteCourseUseCase deleteCourseUseCase,
  }) : _createCourseUsecase = createCourseUseCase,
       _getAllCourseUsecase = getAllCourseUseCase,
       _deleteCourseUseCase = deleteCourseUseCase,
       super(CourseViewState.initial()) {
    on<LoadCourses>(_onLoadCourses);
    on<AddCourse>(_onAddCourse);
    on<DeleteCourse>(_onDeleteCourse);

    // call this event whenever the bloc is created
    add(LoadCourses());
  }

  Future<void> _onLoadCourses(
    LoadCourses event,
    Emitter<CourseViewState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllCourseUsecase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (courses) => emit(state.copyWith(isLoading: false, courses: courses)),
    );
  }

  Future<void> _onAddCourse(
    AddCourse event,
    Emitter<CourseViewState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createCourseUsecase.call(
      CreateCourseParams(courseName: event.courseName),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (courses) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadCourses());
      },
    );
  }

  Future<void> _onDeleteCourse(
    DeleteCourse event,
    Emitter<CourseViewState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteCourseUseCase.call(
      DeleteCourseParams(courseId: event.courseId),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (courses) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadCourses());
      },
    );
  }
}
