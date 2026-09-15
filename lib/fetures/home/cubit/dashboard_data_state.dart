import 'package:tayf/fetures/home/model/telemetry_model.dart';

sealed class TelemetryState {}

final class TelemetryInitial extends TelemetryState {}

final class TelemetryLoading extends TelemetryState {}

final class TelemetryLoaded extends TelemetryState {
  final TelemetryResponse telemetry;

  TelemetryLoaded({required this.telemetry});
}

final class TelemetryError extends TelemetryState {
  final String error;

  TelemetryError({required this.error});
}
