import 'package:student_management/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<List<AuthEntity>> getStudents();
  Future<void> createStudent(AuthEntity student);
  Future<void> deleteStudent(String id);
}