import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tayf/fetures/home/cubit/dashboard_data_state.dart';
import 'package:tayf/fetures/home/model/telemetry_model.dart';
import 'package:tayf/fetures/home/service/telemetry_service.dart';

class TelemetryCubit extends Cubit<TelemetryState> {
  TelemetryCubit({required this.plantId, required this.inverterId})
    : super(TelemetryInitial());

  final int plantId;
  final int inverterId;

  Future<void> fetchTelemetry({
    String? from,
    String? to,
    int page = 1,
    int pageSize = 50,
  }) async {
    emit(TelemetryLoading());

    try {
      final telemetry = await TelemetryService.getTelemetry(
        plantId: plantId,
        inverterId: inverterId,
        from: from,
        to: to,
        page: page,
        pageSize: pageSize,
      );

      emit(TelemetryLoaded(telemetry: telemetry));
    } catch (e) {
      emit(TelemetryError(error: e.toString()));
    }
  }
}
