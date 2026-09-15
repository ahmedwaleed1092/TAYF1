import 'package:tayf/core/api/api_helper.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/fetures/home/model/telemetry_model.dart';

class TelemetryService {
  static Future<TelemetryResponse> getTelemetry({
    required int plantId,
    required int inverterId,
    String? from,
    String? to,
    int page = 1,
    int pageSize = 50,
  }) async {
    final response = await DioHelper.getData(
      endPoints:
          'https://tayfbackend-production.up.railway.app/api/v1/Telemetry',
      query: {
        'PlantId': plantId,
        'InverterId': inverterId,
        if (from != null) 'From': from,
        if (to != null) 'To': to,
        'Page': page,
        'PageSize': pageSize,
      },
    );

    return TelemetryResponse.fromJson(response.data);
  }
}
