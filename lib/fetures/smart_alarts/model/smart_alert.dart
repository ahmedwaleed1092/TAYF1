// lib/features/alerts/data/models/alert_model.dart

class AlertModel {
  final String severity;
  final String asset;
  final String problem;
  final String rootCause;
  final double energyLossKwh;
  final double financialLossEgp;
  final String recommendedAction;

  const AlertModel({
    required this.severity,
    required this.asset,
    required this.problem,
    required this.rootCause,
    required this.energyLossKwh,
    required this.financialLossEgp,
    required this.recommendedAction,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      severity: json['severity'] as String? ?? 'Unknown',
      asset: json['asset'] as String? ?? '-',
      problem: json['problem'] as String? ?? '-',
      rootCause: json['rootCause'] as String? ?? '-',
      energyLossKwh: (json['energyLossKwh'] as num?)?.toDouble() ?? 0,
      financialLossEgp: (json['financialLossEgp'] as num?)?.toDouble() ?? 0,
      recommendedAction: json['recommendedAction'] as String? ?? '-',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'severity': severity,
      'asset': asset,
      'problem': problem,
      'rootCause': rootCause,
      'energyLossKwh': energyLossKwh,
      'financialLossEgp': financialLossEgp,
      'recommendedAction': recommendedAction,
    };
  }
}
