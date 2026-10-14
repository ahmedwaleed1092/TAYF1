import 'package:equatable/equatable.dart';
import 'package:tayf/fetures/performance/model/sensior_reading.dart';

enum SensorStatus { initial, connecting, live, error }

class SensorState extends Equatable {
  final SensorStatus status;
  final SensorReading? latest;
  final List<SensorReading> history;
  final String? error;

  const SensorState({
    this.status = SensorStatus.initial,
    this.latest,
    this.history = const [],
    this.error,
  });

  SensorState copyWith({
    SensorStatus? status,
    SensorReading? latest,
    List<SensorReading>? history,
    String? error,
  }) => SensorState(
    status: status ?? this.status,
    latest: latest ?? this.latest,
    history: history ?? this.history,
    error: error,
  );

  @override
  List<Object?> get props => [status, latest, history, error];
}
