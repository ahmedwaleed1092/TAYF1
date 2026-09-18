import 'package:tayf/core/api/api_helper.dart';
import 'package:tayf/fetures/analytics/models/root_cause.dart';

class RootCauseService {
  static const String _baseUrl =
      'https://tayfbackend-production.up.railway.app/api/v1/diagnosis/root-cause-from-dataset?rowIndex=1';

  static Future<Analysis> getRootCauseAnalysis() async {
    final response = await DioHelper.getData(endPoints: _baseUrl);

    return Analysis.fromJson(response.data as Map<String, dynamic>);
  }
}
