import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:tayf/fetures/soillingAnalysis/cubit/soilling_state.dart';
import 'package:tayf/fetures/soillingAnalysis/service/soiling_service.dart';

class SoilingCubit extends Cubit<SoilingState> {
  SoilingCubit() : super(SoilingInitial());

  Future<void> getSoilingStatus({int plantId = 1}) async {
    emit(SoilingLoading());

    try {
      final status = await SoilingService.getSoilingStatus(plantId: plantId);
      if (isClosed) return;
      emit(SoilingLoaded(status: status));
    } catch (e) {
      log('Soiling status error: $e');
      if (isClosed) return;
      emit(SoilingError(error: e.toString()));
    }
  }
}
