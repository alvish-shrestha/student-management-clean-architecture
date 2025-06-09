import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/auth/data/data_source/auth_data_source.dart';
import 'package:student_management/features/auth/data/model/auth_hive_model.dart';
import 'package:student_management/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  // 2ta class mathi depend
  final HiveService hiveService;
  final AuthHiveModel authHiveModel;

  AuthLocalDataSource({required this.hiveService, required this.authHiveModel});

  @override
  Future<void> createStudent(AuthEntity student) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      await hiveService.addStudent(AuthHiveModel.fromEntity(student));
    } catch (e) {
      throw Exception("Failed to add student: $e");
    }
  }

  @override
  Future<void> deleteStudent(String id) async {
    try {
      await hiveService.deleteStudent(id);
    } catch (e) {
      throw Exception("Failed to delete student: $e");
    }
  }

  @override
  Future<List<AuthEntity>> getStudents() async {
    try {
      final students = await hiveService.getAllStudents();
      return AuthHiveModel.toEntityList(students);
    } catch (e) {
      throw Exception("Failed to get student: $e");
    }
  }
}