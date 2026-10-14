// lib/fetures/financial_loss/cubit/financial_loss_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:tayf/core/api/api_helper.dart';
import 'package:tayf/fetures/financial/cubit/financial_state.dart';
import 'package:tayf/fetures/financial/models/financial_loss_model.dart';

class FinancialLossCubit extends Cubit<FinancialLossState> {
  FinancialLossCubit() : super(FinancialLossInitial());

  Future<void> getFinancialLoss({
    required int plantId,
    required String tariffType,
  }) async {
    emit(FinancialLossLoading());

    try {
      final response = await DioHelper.getData(
        endPoints: "https://tayfbackend-production-e4fd.up.railway.app/api/v1/analysis/financial-loss?plantId=1&tariffType=4",
        // query: {'plantId': plantId, 'tariffType': tariffType},
      );

      print('================ FINANCIAL LOSS ================');
      print(response.data);
      print('Response Type: ${response.data.runtimeType}');
      print('=================================================');

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        emit(
          FinancialLossError(error: 'Invalid financial loss response format'),
        );
        return;
      }

      final financialLoss = FinancialLossModel.fromJson(data);

      emit(
        FinancialLossSuccess(
          message: 'Financial loss fetched successfully',
          financialLoss: financialLoss,
        ),
      );
    } catch (e, stackTrace) {
      print('============= FINANCIAL LOSS ERROR =============');
      print(e);
      print(stackTrace);
      print('=================================================');

      emit(FinancialLossError(error: e.toString()));
    }
  }
}
