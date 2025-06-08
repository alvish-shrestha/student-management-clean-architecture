import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/course/data/data_source/course_data_source.dart';
import 'package:student_management/features/course/data/model/course_hive_model.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

// 2ta class mathi depend
class CourseLocalDataSource implements ICourseDataSource {
  // 2ta class mathi depend
  final HiveService hiveService;
  // final CourseHiveModel courseHiveModel;

  CourseLocalDataSource({
    required this.hiveService,
    // required this.courseHiveModel,
  });

  @override
  Future<void> createCourse(CourseEntity course) async {
    try {
      // Convert CourseEntity to CourseHiveModel
      await hiveService.addCourse(CourseHiveModel.fromEntity(course));
    } catch (e) {
      throw Exception("Failed to add course: $e");
    }
  }

  @override
  Future<void> deleteCourse(String id) async {
    try {
      await hiveService.deleteCourse(id);
    } catch (e) {
      throw Exception("Failed to delete course: $e");
    }
  }

  @override
  Future<List<CourseEntity>> getCourses() async {
    try {
      final courses = await hiveService.getAllCourses();
      return CourseHiveModel.toEntityList(courses);
    } catch (e) {
      throw Exception("Failed to get course: $e");
    }
  }
}
