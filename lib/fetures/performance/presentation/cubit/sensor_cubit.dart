import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayf/fetures/performance/model/sensior_reading.dart';
import 'package:tayf/fetures/performance/presentation/cubit/sensor_state.dart';
import 'package:tayf/fetures/performance/service/swnsor_stream__service.dart';

class SensorCubit extends Cubit<SensorState> {
  final SensorStreamService _service;
  StreamSubscription<SensorReading>? _sub;
  Timer? _retryTimer;
  static const int _maxHistory = 50;

  SensorCubit(this._service) : super(const SensorState());

  void start() {
    _sub?.cancel();
    _retryTimer?.cancel();
    emit(state.copyWith(status: SensorStatus.connecting));

    _sub = _service.readings().listen(
      (reading) {
        if (isClosed) return;
        final updated = [...state.history, reading];
        if (updated.length > _maxHistory) {
          updated.removeRange(0, updated.length - _maxHistory);
        }
        emit(
          state.copyWith(
            status: SensorStatus.live,
            latest: reading,
            history: updated,
          ),
        );
      },
      onError: (e) {
        if (isClosed) return;
        emit(state.copyWith(status: SensorStatus.error, error: e.toString()));
        _retryTimer = Timer(const Duration(seconds: 3), start);
      },
      cancelOnError: true,
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    _retryTimer?.cancel();
    return super.close();
  }
}
