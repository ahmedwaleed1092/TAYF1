class Analysis {
  final int rowIndex;
  final RootCauseInput input;
  final Prediction prediction;

  const Analysis({
    required this.rowIndex,
    required this.input,
    required this.prediction,
  });

  factory Analysis.fromJson(Map<String, dynamic> json) {
    return Analysis(
      rowIndex: json['rowIndex'] as int? ?? 0,
      input: RootCauseInput.fromJson(
        json['input'] as Map<String, dynamic>? ?? {},
      ),
      prediction: Prediction.fromJson(
        json['prediction'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rowIndex': rowIndex,
      'input': input.toJson(),
      'prediction': prediction.toJson(),
    };
  }
}

class RootCauseInput {
  final double vdc1;
  final double vdc2;
  final double idc1;
  final double idc2;
  final double irr;
  final double pvt;
  final int expectedFaultLabel;

  const RootCauseInput({
    required this.vdc1,
    required this.vdc2,
    required this.idc1,
    required this.idc2,
    required this.irr,
    required this.pvt,
    required this.expectedFaultLabel,
  });

  factory RootCauseInput.fromJson(Map<String, dynamic> json) {
    return RootCauseInput(
      vdc1: (json['vdc1'] as num?)?.toDouble() ?? 0,
      vdc2: (json['vdc2'] as num?)?.toDouble() ?? 0,
      idc1: (json['idc1'] as num?)?.toDouble() ?? 0,
      idc2: (json['idc2'] as num?)?.toDouble() ?? 0,
      irr: (json['irr'] as num?)?.toDouble() ?? 0,
      pvt: (json['pvt'] as num?)?.toDouble() ?? 0,
      expectedFaultLabel: (json['expectedFaultLabel'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vdc1': vdc1,
      'vdc2': vdc2,
      'idc1': idc1,
      'idc2': idc2,
      'irr': irr,
      'pvt': pvt,
      'expectedFaultLabel': expectedFaultLabel,
    };
  }
}

class Prediction {
  final String topClass;
  final Map<String, double> classification;
  final Map<String, double> causes;
  final double confidence;
  final String status;
  final double pTotal;
  final double pExpected;
  final double deviation;

  const Prediction({
    required this.topClass,
    required this.classification,
    required this.causes,
    required this.confidence,
    required this.status,
    required this.pTotal,
    required this.pExpected,
    required this.deviation,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      topClass: json['topClass'] as String? ?? '-',
      classification: _parseDoubleMap(
        json['classification'] as Map<String, dynamic>? ?? {},
      ),
      causes: _parseDoubleMap(json['causes'] as Map<String, dynamic>? ?? {}),
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? '-',
      pTotal: (json['pTotal'] as num?)?.toDouble() ?? 0,
      pExpected: (json['pExpected'] as num?)?.toDouble() ?? 0,
      deviation: (json['deviation'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topClass': topClass,
      'classification': classification,
      'causes': causes,
      'confidence': confidence,
      'status': status,
      'pTotal': pTotal,
      'pExpected': pExpected,
      'deviation': deviation,
    };
  }

  static Map<String, double> _parseDoubleMap(Map<String, dynamic> map) {
    return map.map(
      (key, value) => MapEntry(key, (value as num?)?.toDouble() ?? 0),
    );
  }
}
