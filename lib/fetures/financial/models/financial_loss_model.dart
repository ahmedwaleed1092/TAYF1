// lib/fetures/financial_loss/model/financial_loss_model.dart

class FinancialLossModel {
  final double energyLossKwh;
  final String tariffType;
  final double tariffRate;
  final String currency;
  final double estimatedLoss;

  const FinancialLossModel({
    required this.energyLossKwh,
    required this.tariffType,
    required this.tariffRate,
    required this.currency,
    required this.estimatedLoss,
  });

  factory FinancialLossModel.fromJson(Map<String, dynamic> json) {
    return FinancialLossModel(
      energyLossKwh: _toDouble(json['energyLossKwh']),
      tariffType: json['tariffType']?.toString() ?? '',
      tariffRate: _toDouble(json['tariffRate']),
      currency: json['currency']?.toString() ?? '',
      estimatedLoss: _toDouble(json['estimatedLoss']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'energyLossKwh': energyLossKwh,
      'tariffType': tariffType,
      'tariffRate': tariffRate,
      'currency': currency,
      'estimatedLoss': estimatedLoss,
    };
  }

  static double _toDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }

    if (value is num) {
      return value.toDouble();
    }

    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }

    return 0.0;
  }
}
