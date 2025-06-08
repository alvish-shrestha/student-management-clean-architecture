import 'package:flutter/cupertino.dart';
import 'package:student_management/app/app.dart';
import 'package:student_management/app/service_locator/service_locator.dart';
import 'package:student_management/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  final hiveService = HiveService();
  await hiveService.init();

  runApp(App());
}
