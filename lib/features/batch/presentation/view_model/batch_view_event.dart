import 'package:equatable/equatable.dart';

sealed class BatchViewEvent extends Equatable {
  const BatchViewEvent();

  @override
  List<Object> get props => [];
}

final class LoadBatches extends BatchViewEvent {}

final class AddBatch extends BatchViewEvent {
  final String batchName;
  const AddBatch(this.batchName);

  @override
  List<Object> get props => [batchName];
}

final class DeleteBatch extends BatchViewEvent {
  final String batchId;

  const DeleteBatch(this.batchId);

  @override
  List<Object> get props => [batchId];
}
