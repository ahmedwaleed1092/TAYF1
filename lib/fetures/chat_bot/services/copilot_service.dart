import 'dart:convert';

import 'package:tayf/core/api/api_helper.dart';

class CopilotService {
  static String baseUrl = "https://solar-production-d8bd.up.railway.app/api";
  static Future<Response> sendMessage(String message) async {
    final response = await DioHelper.postRequest(
      endPoints: "$baseUrl/chat",
      data: {"message": message},
    );
    return Response.fromJson(response.data);
  }
}

Response chatModelFromJson(String str) => Response.fromJson(json.decode(str));

String chatModelToJson(Response data) => json.encode(data.toJson());

class Response {
  final String role;
  final String message;

  Response({required this.role, required this.message});

  factory Response.fromJson(Map<String, dynamic> json) =>
      Response(role: "bot", message: json["reply"]);

  Map<String, dynamic> toJson() => {"role": role, "message": message};
}
