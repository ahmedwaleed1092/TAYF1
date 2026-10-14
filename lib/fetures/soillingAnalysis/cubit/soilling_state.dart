import 'package:tayf/fetures/soillingAnalysis/model/soillingstatues_model.dart';

sealed class SoilingState {}

final class SoilingInitial extends SoilingState {}

final class SoilingLoading extends SoilingState {}

final class SoilingLoaded extends SoilingState {
  final SoilingStatus status;

  SoilingLoaded({required this.status});
}

final class SoilingError extends SoilingState {
  final String error;

  SoilingError({required this.error});
}
