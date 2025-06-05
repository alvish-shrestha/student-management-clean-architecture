import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_management/app/constant/hive/hive_table_constant.dart';
import 'package:student_management/features/auth/data/model/auth_hive_model.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/course/data/model/course_hive_model.dart';

class HiveService {
  Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = "${directory.path}student_management.db";

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(CourseHiveModelAdapter());
    Hive.registerAdapter(BatchHiveModelAdapter());
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // ====================== Batch Queries ============================
  Future<void> addBatch(BatchHiveModel batch) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.put(batch.batchId, batch);
  }

  Future<List<BatchHiveModel>> getAllBatches() async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    var batches = box.values.toList();
    return batches;
  }

  Future<void> deleteBatch(String id) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.delete(id);
  }

  // ====================== Course Queries ============================
  Future<void> addCourse(CourseHiveModel course) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.put(course.courseId, course);
  }

  Future<List<CourseHiveModel>> getAllCourses() async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    var courses = box.values.toList();
    return courses;
  }

  Future<void> deleteCourse(String id) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.delete(id);
  }

  // ====================== Student Queries ============================
  Future<void> addStudent(AuthHiveModel student) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    await box.put(student.studentId, student);
  }

  Future<List<AuthHiveModel>> getAllStudents() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    var students = box.values.toList();
    return students;
  }

  Future<void> deleteStudent(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    await box.delete(id);
  }
}
