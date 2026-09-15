part of 'rootcuase_cubit.dart';

@immutable
sealed class RootcuaseState {}

final class RootcuaseInitial extends RootcuaseState {}

final class RootcuaseLoading extends RootcuaseState {}

final class RootcuaseLoaded extends RootcuaseState {
  final Analysis analysis;

  RootcuaseLoaded({required this.analysis});
}

final class RootcuaseError extends RootcuaseState {
  final String error;

  RootcuaseError({required this.error});
}
