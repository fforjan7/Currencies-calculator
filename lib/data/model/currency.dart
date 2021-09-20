class Currency {
  final String currencyName;
  final double currencyRate;
  String currentValue;

  Currency({
    required this.currencyName,
    required this.currencyRate,
    required this.currentValue,
    
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Currency &&
      other.currencyName == currencyName &&
      other.currencyRate == currencyRate;
  }

  @override
  int get hashCode => currencyName.hashCode ^ currencyRate.hashCode;
}
