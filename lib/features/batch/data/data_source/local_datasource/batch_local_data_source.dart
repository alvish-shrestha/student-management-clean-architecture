import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/batch/data/data_source/batch_data_source.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';

// 2ta class mathi depend
class BatchLocalDataSource implements IBatchDataSource {
  // 2ta class mathi depend
  final HiveService hiveService;
  // final BatchHiveModel batchHiveModel;

  BatchLocalDataSource({
    required this.hiveService,
    // required this.batchHiveModel,
  });

  @override
  Future<void> createBatch(BatchEntity batch) async {
    try {
      // Convert BatchEntity to BatchHiveModel
      await hiveService.addBatch(BatchHiveModel.fromEntity(batch));
    } catch (e) {
      throw Exception("Failed to add batch: $e");
    }
  }

  @override
  Future<void> deleteBatch(String id) async {
    try {
      await hiveService.deleteBatch(id);
    } catch (e) {
      throw Exception("Failed to delete batch: $e");
    }
  }

  @override
  Future<List<BatchEntity>> getBatches() async {
    try {
      final batches = await hiveService.getAllBatches();
      return BatchHiveModel.toEntityList(batches);
    } catch (e) {
      throw Exception("Failed to get batch: $e");
    }
  }
}
