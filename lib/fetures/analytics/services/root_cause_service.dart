import 'package:tayf/core/api/api_helper.dart';
import 'package:tayf/fetures/analytics/models/root_cause.dart';

class RootCauseService {
  static const String _baseUrl =
      'https://tayfbackend-production.up.railway.app/api/v1';

  static Future<Analysis> getRootCauseAnalysis({required int rowIndex}) async {
    final response = await DioHelper.getData(
      endPoints:
          '$_baseUrl/diagnosis/root-cause-from-dataset?rowIndex=$rowIndex',
    );

    return Analysis.fromJson(response.data as Map<String, dynamic>);
  }
}
