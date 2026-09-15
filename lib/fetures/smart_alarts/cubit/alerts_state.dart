part of 'alerts_cubit.dart';

@immutable
sealed class AlertsState {}

final class AlertsInitial extends AlertsState {}

final class AlertsLoading extends AlertsState {}

final class AlertsSuccess extends AlertsState {
  final String message;
  final List<AlertModel> alerts;
  AlertsSuccess({required this.message, required this.alerts});
}

final class AlertsError extends AlertsState {
  final String error;
  AlertsError({required this.error});
}
