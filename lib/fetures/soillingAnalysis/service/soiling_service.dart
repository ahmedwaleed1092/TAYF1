import 'package:tayf/core/api/api_helper.dart';
import 'package:tayf/fetures/soillingAnalysis/model/soillingstatues_model.dart';

class SoilingService {
  // الـ DioHelper عندك baseUrl بتاعه فاضي، فبنبعت الـ URL كامل
  static const String _baseUrl =
      'https://tayfbackend-production-e4fd.up.railway.app';

  static Future<SoilingStatus> getSoilingStatus({int plantId = 1}) async {
    final res = await DioHelper.getData(
      endPoints: '$_baseUrl/api/v1/plant/soiling/status',
      query: {'plantId': plantId},
    );
    return SoilingStatus.fromJson(res.data as Map<String, dynamic>);
  }
}
