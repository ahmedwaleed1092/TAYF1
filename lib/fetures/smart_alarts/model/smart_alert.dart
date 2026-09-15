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
      // String fields
      severity: json['severity']?.toString() ?? 'Unknown',
      asset: json['asset']?.toString() ?? '-',
      problem: json['problem']?.toString() ?? '-',
      rootCause: json['rootCause']?.toString() ?? '-',
      recommendedAction: json['recommendedAction']?.toString() ?? '-',

      // Numeric fields
      energyLossKwh: _toDouble(json['energyLossKwh']),
      financialLossEgp: _toDouble(json['financialLossEgp']),
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

  static double _toDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }

    // Handles int and double
    if (value is num) {
      return value.toDouble();
    }

    // Handles numeric String
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }

    return 0.0;
  }
}
