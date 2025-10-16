class Coin {
  final String id;
  final String name;
  final String symbol;

  Coin({required this.id, required this.name, required this.symbol});

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
    id: json['id'],
    name: json['name'],
    symbol: json['symbol'],
  );
}
