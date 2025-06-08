import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_event.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_state.dart';

class BatchViewBloc extends Bloc<BatchViewEvent, BatchViewState> {
  final CreateBatchUsecase _createBatchUsecase;
  final GetAllBatchUsecase _getAllBatchUsecase;
  final DeleteBatchUseCase _deleteBatchUseCase;

  BatchViewBloc({
    required CreateBatchUsecase createBatchUseCase,
    required GetAllBatchUsecase getAllBatchUseCase,
    required DeleteBatchUseCase deleteBatchUseCase,
  }) : _createBatchUsecase = createBatchUseCase,
       _getAllBatchUsecase = getAllBatchUseCase,
       _deleteBatchUseCase = deleteBatchUseCase,
       super(BatchViewState.initial()) {
    on<LoadBatches>(_onLoadBatches);
    on<AddBatch>(_onAddBatch);
    on<DeleteBatch>(_onDeleteBatch);

    // call this event whenever the bloc is created
    add(LoadBatches());
  }

  Future<void> _onLoadBatches(
    LoadBatches event,
    Emitter<BatchViewState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllBatchUsecase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) => emit(state.copyWith(isLoading: false, batches: batches)),
    );
  }

  Future<void> _onAddBatch(AddBatch event, Emitter<BatchViewState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createBatchUsecase.call(
      CreateBatchParams(batchName: event.batchName),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadBatches());
      },
    );
  }

  Future<void> _onDeleteBatch(
    DeleteBatch event,
    Emitter<BatchViewState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteBatchUseCase.call(
      DeleteBatchParams(batchId: event.batchId),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadBatches());
      },
    );
  }
}
