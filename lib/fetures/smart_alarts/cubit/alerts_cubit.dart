import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tayf/core/api/api_helper.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/fetures/smart_alarts/model/smart_alert.dart';

part 'alerts_state.dart';

class AlertsCubit extends Cubit<AlertsState> {
  AlertsCubit() : super(AlertsInitial());
  Future<void> getAlerts() async {
    emit(AlertsLoading());
    try {
      final response = await DioHelper.getData(
        endPoints: ApiConstant.getAlerts,
      );
      final alerts = (response.data['data'] as List<dynamic>?)
          ?.map((e) => AlertModel.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(
        AlertsSuccess(
          message: 'Alerts fetched successfully',
          alerts: alerts ?? [],
        ),
      );
    } catch (e) {
      emit(AlertsError(error: e.toString()));
    }
  }
}
