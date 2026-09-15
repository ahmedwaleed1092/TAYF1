class TelemetryResponse {
  final List<TelemetryModel> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasPreviousPage;
  final bool hasNextPage;

  TelemetryResponse({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory TelemetryResponse.fromJson(Map<String, dynamic> json) {
    return TelemetryResponse(
      items: json['items'] == null
          ? []
          : List<TelemetryModel>.from(
              json['items'].map((item) => TelemetryModel.fromJson(item)),
            ),
      pageNumber: json['pageNumber'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      totalCount: json['totalCount'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
      hasNextPage: json['hasNextPage'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'totalPages': totalPages,
      'hasPreviousPage': hasPreviousPage,
      'hasNextPage': hasNextPage,
    };
  }
}

class TelemetryModel {
  final int id;
  final int plantId;
  final int inverterId;
  final DateTime timestamp;
  final double acPowerKw;
  final double dcPowerKw;
  final double irradiance;
  final double ambientTemperature;
  final double moduleTemperature;
  final double dailyYield;
  final double totalYield;

  TelemetryModel({
    required this.id,
    required this.plantId,
    required this.inverterId,
    required this.timestamp,
    required this.acPowerKw,
    required this.dcPowerKw,
    required this.irradiance,
    required this.ambientTemperature,
    required this.moduleTemperature,
    required this.dailyYield,
    required this.totalYield,
  });

  factory TelemetryModel.fromJson(Map<String, dynamic> json) {
    return TelemetryModel(
      id: json['id'] ?? 0,
      plantId: json['plantId'] ?? 0,
      inverterId: json['inverterId'] ?? 0,
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      acPowerKw: (json['acPowerKw'] ?? 0).toDouble(),
      dcPowerKw: (json['dcPowerKw'] ?? 0).toDouble(),
      irradiance: (json['irradiance'] ?? 0).toDouble(),
      ambientTemperature: (json['ambientTemperature'] ?? 0).toDouble(),
      moduleTemperature: (json['moduleTemperature'] ?? 0).toDouble(),
      dailyYield: (json['dailyYield'] ?? 0).toDouble(),
      totalYield: (json['totalYield'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plantId': plantId,
      'inverterId': inverterId,
      'timestamp': timestamp.toIso8601String(),
      'acPowerKw': acPowerKw,
      'dcPowerKw': dcPowerKw,
      'irradiance': irradiance,
      'ambientTemperature': ambientTemperature,
      'moduleTemperature': moduleTemperature,
      'dailyYield': dailyYield,
      'totalYield': totalYield,
    };
  }
}
