import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/portfolio_bloc.dart';
import '../../logic/bloc/portfolio_event.dart';
import '../../data/models/portfolio_model.dart';
import '../../data/services/api_service.dart';
import '../../data/models/coin_model.dart';

class AddAssetScreen extends StatefulWidget {
  const AddAssetScreen({super.key});

  @override
  State<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final ApiService apiService = ApiService();

  List<Coin> _allCoins = [];
  List<Coin> _filteredCoins = [];
  Coin? _selectedCoin;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCoins();
  }

  Future<void> _loadCoins() async {
    final result = await apiService.fetchCoinsList();
    _allCoins = result.map((json) => Coin.fromJson(json)).toList();
    setState(() {
      _filteredCoins = _allCoins;
      _isLoading = false;
    });
  }

  void _filterCoins(String query) {
    final filtered = _allCoins
        .where((c) =>
    c.name.toLowerCase().contains(query.toLowerCase()) ||
        c.symbol.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredCoins = filtered;
    });
  }

  void _addCoin() {
    final qty = double.tryParse(_quantityController.text);
    if (_selectedCoin == null || qty == null || qty <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a valid coin & quantity')),
      );
      return;
    }

    final item = PortfolioItem(
      coinId: _selectedCoin!.id,
      coinName: _selectedCoin!.name,
      symbol: _selectedCoin!.symbol,
      quantity: qty,
    );

    context.read<PortfolioBloc>().add(AddAsset(item));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Asset')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterCoins,
              decoration: const InputDecoration(
                hintText: 'Search Coin (e.g., Bitcoin, BTC)',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredCoins.length,
                itemBuilder: (context, i) {
                  final coin = _filteredCoins[i];
                  return ListTile(
                    title: Text(coin.name),
                    subtitle: Text(coin.symbol.toUpperCase()),
                    onTap: () {
                      setState(() => _selectedCoin = coin);
                      _searchController.text = coin.name;
                      FocusScope.of(context).unfocus();
                    },
                    selected: _selectedCoin == coin,
                    selectedTileColor: Colors.yellow.withOpacity(0.2),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter quantity owned',
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _addCoin,
              icon: const Icon(Icons.save),
              label: const Text('Add to Portfolio'),
            ),
          ],
        ),
      ),
    );
  }
}
