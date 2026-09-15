part of 'wither_cubit.dart';

@immutable
sealed class WitherState {}

final class WitherInitial extends WitherState {}

final class WitherLoading extends WitherState {}

final class WitherLoaded extends WitherState {
  final WeatherModel weatherModel;
  WitherLoaded(this.weatherModel);
}

final class WitherError extends WitherState {
  final String error;
  WitherError(this.error);
}
