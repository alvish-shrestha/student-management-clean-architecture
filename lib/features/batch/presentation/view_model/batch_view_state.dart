import 'package:equatable/equatable.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';

class BatchViewState extends Equatable {
  final List<BatchEntity> batches;
  final bool isLoading;
  final String? error;

  const BatchViewState({
    required this.batches,
    required this.isLoading,
    this.error,
  });

  factory BatchViewState.initial() {
    return BatchViewState(batches: [], isLoading: false);
  }

  BatchViewState copyWith({
    List<BatchEntity>? batches,
    bool? isLoading,
    String? error,
  }) {
    return BatchViewState(
      batches: batches ?? this.batches,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [batches, isLoading, error];
}
