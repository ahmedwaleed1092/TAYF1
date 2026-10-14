import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tayf/fetures/performance/model/sensior_reading.dart';

class SensorStreamService {
  static const String url =
      'https://streaming-expected-ac-power-production-5c58.up.railway.app/stream';

  Stream<SensorReading> readings() async* {
    final client = http.Client();
    try {
      final request = http.Request('GET', Uri.parse(url))
        ..headers['Accept'] = 'text/event-stream'
        ..headers['Cache-Control'] = 'no-cache';

      final response = await client.send(request);

      if (response.statusCode != 200) {
        throw Exception('Server error: ${response.statusCode}');
      }

      final lines = response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      await for (final rawLine in lines) {
        final line = rawLine.trim();
        if (line.isEmpty || line.startsWith(':')) continue; // heartbeat/comment

        String? jsonStr;
        if (line.startsWith('data:')) {
          jsonStr = line.substring(5).trim();
        } else if (line.startsWith('{')) {
          jsonStr = line; // NDJSON
        }
        if (jsonStr == null || jsonStr.isEmpty) continue;

        try {
          final map = jsonDecode(jsonStr) as Map<String, dynamic>;
          yield SensorReading.fromJson(map);
        } catch (_) {
          // تجاهل أي رسالة مش صالحة
        }
      }
      throw Exception('Stream closed by server');
    } finally {
      client.close(); // بيتقفل تلقائيًا لما الـ subscription يتلغي
    }
  }
}
