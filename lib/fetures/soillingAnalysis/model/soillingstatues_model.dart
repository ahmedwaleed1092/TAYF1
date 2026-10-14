/// GET /api/v1/plant/soiling/status?plantId=1
class SoilingStatus {
  final int plantId;
  final double currentSoilingLossPct;
  final int daysSinceLastCleaning;
  final double estimatedRecoveryKwh;
  final DateTime? lastCleaningDate; // nullable في الـ response
  final String recommendation;

  const SoilingStatus({
    required this.plantId,
    required this.currentSoilingLossPct,
    required this.daysSinceLastCleaning,
    required this.estimatedRecoveryKwh,
    required this.lastCleaningDate,
    required this.recommendation,
  });

  factory SoilingStatus.fromJson(Map<String, dynamic> json) {
    final rawDate = json['lastCleaningDate'] as String?;

    return SoilingStatus(
      plantId: (json['plantId'] as num?)?.toInt() ?? 0,
      currentSoilingLossPct:
          (json['currentSoilingLossPct'] as num?)?.toDouble() ?? 0,
      daysSinceLastCleaning:
          (json['daysSinceLastCleaning'] as num?)?.toInt() ?? 0,
      estimatedRecoveryKwh:
          (json['estimatedRecoveryKwh'] as num?)?.toDouble() ?? 0,
      lastCleaningDate: rawDate == null ? null : DateTime.tryParse(rawDate),
      recommendation: json['recommendation'] as String? ?? '',
    );
  }
}
