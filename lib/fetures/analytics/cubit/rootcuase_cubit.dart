import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tayf/fetures/analytics/models/root_cause.dart';
import 'package:tayf/fetures/analytics/services/root_cause_service.dart';

part 'rootcuase_state.dart';

class RootcuaseCubit extends Cubit<RootcuaseState> {
  final int rowIndex;

  RootcuaseCubit({required this.rowIndex}) : super(RootcuaseInitial()) {
    fetchRootCause();
  }

  Future<void> fetchRootCause() async {
    emit(RootcuaseLoading());

    try {
      final analysis = await RootCauseService.getRootCauseAnalysis(
        rowIndex: rowIndex,
      );

      emit(RootcuaseLoaded(analysis: analysis));
    } catch (e) {
      emit(RootcuaseError(error: e.toString()));
    }
  }
}
