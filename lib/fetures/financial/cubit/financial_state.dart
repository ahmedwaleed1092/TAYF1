import 'package:tayf/fetures/financial/models/financial_loss_model.dart';

sealed class FinancialLossState {}

final class FinancialLossInitial extends FinancialLossState {}

final class FinancialLossLoading extends FinancialLossState {}

final class FinancialLossSuccess extends FinancialLossState {
  final String message;
  final FinancialLossModel financialLoss;

  FinancialLossSuccess({required this.message, required this.financialLoss});
}

final class FinancialLossError extends FinancialLossState {
  final String error;

  FinancialLossError({required this.error});
}
