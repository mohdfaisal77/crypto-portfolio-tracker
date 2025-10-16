import '../services/api_service.dart';
import '../local/local_storage.dart';
import '../models/portfolio_model.dart';

class CryptoRepository {
  final ApiService api;
  final LocalStorage storage;

  CryptoRepository(this.api, this.storage);
  Future<PortfolioItem> fetchCoinWithLogo(String id, double quantity) async {
    final details = await api.fetchCoinDetails(id);
    return PortfolioItem(
      coinId: id,
      coinName: details['name'],
      symbol: details['symbol'],
      quantity: quantity,
      logoUrl: details['logo'],
    );
  }

  Future<List<PortfolioItem>> loadPortfolio() => storage.loadPortfolio();
  Future<void> savePortfolio(List<PortfolioItem> portfolio) =>
      storage.savePortfolio(portfolio);

  Future<Map<String, double>> fetchPrices(List<String> ids) async {
    final response = await api.fetchPrices(ids);
    return response.map((k, v) => MapEntry(k, v['usd']?.toDouble() ?? 0.0));
  }
}
