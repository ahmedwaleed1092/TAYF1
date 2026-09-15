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

      print('================ ALERT RESPONSE ================');
      print(response.data);
      print('Response Type: ${response.data.runtimeType}');
      print('=================================================');

      final dynamic data = response.data;

      List<dynamic> alertsJson;

      // Case 1:
      // API returns directly:
      // [
      //   {...},
      //   {...}
      // ]
      if (data is List) {
        alertsJson = data;
      }
      // Case 2:
      // API returns:
      // {
      //   "data": [
      //     {...},
      //     {...}
      //   ]
      // }
      else if (data is Map<String, dynamic>) {
        final dynamic innerData = data['data'];

        if (innerData is List) {
          alertsJson = innerData;
        } else {
          alertsJson = [];
        }
      }
      // Unknown response format
      else {
        alertsJson = [];
      }

      final alerts = alertsJson
          .whereType<Map<String, dynamic>>()
          .map((json) => AlertModel.fromJson(json))
          .toList();

      emit(
        AlertsSuccess(message: 'Alerts fetched successfully', alerts: alerts),
      );
    } catch (e, stackTrace) {
      print('================ ALERT ERROR ================');
      print(e);
      print(stackTrace);
      print('=============================================');

      emit(AlertsError(error: e.toString()));
    }
  }
}
