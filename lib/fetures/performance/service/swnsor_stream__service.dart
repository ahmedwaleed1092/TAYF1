import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tayf/fetures/performance/model/sensior_reading.dart';

class SensorStreamService {
  static const String url =
      'https://streaming-expected-ac-power-production-5c58.up.railway.app/stream';

  final Dio _dio;

  SensorStreamService({Dio? dio})
    : _dio =
          dio ??
          (Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: Duration.zero,
              ),
            )
            ..interceptors.add(
              PrettyDioLogger(
                requestHeader: true,
                requestBody: false,
                responseHeader: true,
                responseBody: false,
                error: true,
                compact: true,
              ),
            ));

  static const JsonEncoder _pretty = JsonEncoder.withIndent('  ');

  void _logMessage(Map<String, dynamic> map) {
    final text = _pretty.convert(map);
    debugPrint('╔══ SSE Response ══════════════════════════');
    for (final line in text.split('\n')) {
      debugPrint('║ $line');
    }
    debugPrint('╚══════════════════════════════════════════');
  }

  Stream<SensorReading> readings() async* {
    final response = await _dio.get<ResponseBody>(
      url,
      options: Options(
        responseType: ResponseType.stream,
        headers: {'Accept': 'text/event-stream', 'Cache-Control': 'no-cache'},
      ),
    );

    final body = response.data;
    if (body == null) throw Exception('Empty response');

    final lines = body.stream
        .cast<List<int>>()
        .transform(utf8.decoder)
        .transform(const LineSplitter());

    await for (final rawLine in lines) {
      final line = rawLine.trim();
      if (line.isEmpty || line.startsWith(':')) continue;

      String? jsonStr;
      if (line.startsWith('data:')) {
        jsonStr = line.substring(5).trim();
      } else if (line.startsWith('{')) {
        jsonStr = line;
      }
      if (jsonStr == null || jsonStr.isEmpty) continue;

      try {
        final map = jsonDecode(jsonStr) as Map<String, dynamic>;
        if (kDebugMode) _logMessage(map);
        yield SensorReading.fromJson(map);
      } catch (e) {
        debugPrint('SSE parse error: $e | raw: $jsonStr');
      }
    }

    throw Exception('Stream closed by server');
  }
}
