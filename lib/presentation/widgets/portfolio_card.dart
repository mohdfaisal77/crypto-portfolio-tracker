import 'package:flutter/material.dart';
import '../../data/models/portfolio_model.dart';
import 'package:intl/intl.dart';

class PortfolioCard extends StatelessWidget {
  final PortfolioItem item;
  final double price;

  const PortfolioCard({super.key, required this.item, required this.price});

  @override
  Widget build(BuildContext context) {
    final totalValue = item.quantity * price;
    final formatter = NumberFormat.currency(symbol: '\$');

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: item.logoUrl != null
      ? CircleAvatar(
      backgroundImage: NetworkImage(item.logoUrl!),
      radius: 20,
    )
        : const Icon(Icons.monetization_on, color: Colors.amber),

    title: Text(item.coinName),
        subtitle: Text('${item.symbol.toUpperCase()} - Qty: ${item.quantity}'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(formatter.format(price), style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              formatter.format(totalValue),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
