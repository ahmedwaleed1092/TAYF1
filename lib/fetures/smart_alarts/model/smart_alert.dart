enum AlertSeverity { high, medium, info }

class SmartAlert {
  final AlertSeverity severity;
  final String title;
  final String energyLoss;
  final String financialLoss;
  final String probableCause;
  final String action;
  final bool isNormal;

  const SmartAlert({
    required this.severity,
    required this.title,
    this.energyLoss = '',
    this.financialLoss = '',
    this.probableCause = '',
    this.action = '',
    this.isNormal = false,
  });
}
