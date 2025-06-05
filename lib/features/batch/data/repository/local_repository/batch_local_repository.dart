import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/batch/data/data_source/local_datasource/batch_local_data_source.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/domain/repository/batch_repository.dart';

class BatchLocalRepository implements IBatchRepository {
  final BatchLocalDataSource _batchLocalDataSource;

  BatchLocalRepository({required BatchLocalDataSource batchLocalDataSource})
    : _batchLocalDataSource = batchLocalDataSource;

  @override
  Future<Either<Failure, void>> createBatch(BatchEntity batch) async {
    try {
      _batchLocalDataSource.createBatch(batch);
      return (Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(String id) async {
    try {
      _batchLocalDataSource.deleteBatch(id);
      return Right(null);
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getBatches() async {
    try {
      final List<BatchEntity> batches = await _batchLocalDataSource
          .getBatches();
      return Right(batches);
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}
