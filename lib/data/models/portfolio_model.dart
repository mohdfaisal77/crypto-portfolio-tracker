class PortfolioItem {
  final String coinId;
  final String coinName;
  final String symbol;
  final double quantity;
  final String? logoUrl;

  PortfolioItem({
    required this.coinId,
    required this.coinName,
    required this.symbol,
    required this.quantity,
    this.logoUrl,
  });

  Map<String, dynamic> toJson() => {
    'coinId': coinId,
    'coinName': coinName,
    'symbol': symbol,
    'quantity': quantity,
    'logoUrl': logoUrl,
  };

  factory PortfolioItem.fromJson(Map<String, dynamic> json) => PortfolioItem(
    coinId: json['coinId'],
    coinName: json['coinName'],
    symbol: json['symbol'],
    quantity: json['quantity'],
    logoUrl: json['logoUrl'],
  );
}
