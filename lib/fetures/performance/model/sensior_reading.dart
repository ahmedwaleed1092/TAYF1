import 'package:equatable/equatable.dart';

class SensorReading extends Equatable {
  final String source;
  final String sensorId;
  final DateTime timestamp;
  final double poaIrradiance;
  final double moduleTemp;
  final double ambientTemp;
  final double expectedPowerNorm;
  final bool daytime;
  final int seq;
  final String boot;

  const SensorReading({
    required this.source,
    required this.sensorId,
    required this.timestamp,
    required this.poaIrradiance,
    required this.moduleTemp,
    required this.ambientTemp,
    required this.expectedPowerNorm,
    required this.daytime,
    required this.seq,
    required this.boot,
  });

  factory SensorReading.fromJson(Map<String, dynamic> json) {
    return SensorReading(
      source: json['source']?.toString() ?? '',
      sensorId: json['sensor_id']?.toString() ?? '',
      timestamp: DateTime.parse(json['timestamp'] as String),
      poaIrradiance: (json['poa_irradiance'] as num).toDouble(),
      moduleTemp: (json['module_temp'] as num).toDouble(),
      ambientTemp: (json['ambient_temp'] as num).toDouble(),
      expectedPowerNorm: (json['expected_power_norm'] as num).toDouble(),
      daytime: json['daytime'] as bool? ?? false,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
      boot: json['boot']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [sensorId, timestamp, seq, boot];
}
