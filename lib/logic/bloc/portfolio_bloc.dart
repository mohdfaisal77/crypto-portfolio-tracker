import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/portfolio_model.dart';
import '../../data/repositories/crypto_repository.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final CryptoRepository repository;

  PortfolioBloc(this.repository) : super(const PortfolioState()) {
    on<LoadPortfolio>(_onLoadPortfolio);
    on<AddAsset>(_onAddAsset);
    on<RemoveAsset>(_onRemoveAsset);
    on<RefreshPrices>(_onRefreshPrices);
    on<SortPortfolio>(_onSortPortfolio);
  }

  Future<void> _onLoadPortfolio(LoadPortfolio event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(isLoading: true));
    final data = await repository.loadPortfolio();
    final sorted = _sortPortfolio(data, state.sortOption, state.prices);
    emit(state.copyWith(portfolio: sorted, isLoading: false));
    add(RefreshPrices());
  }

  Future<void> _onAddAsset(AddAsset event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(isAdding: true));
    var item = event.item;

    if (item.logoUrl == null) {
      final details = await repository.api.fetchCoinDetails(item.coinId);
      item = PortfolioItem(
        coinId: item.coinId,
        coinName: item.coinName,
        symbol: item.symbol,
        quantity: item.quantity,
        logoUrl: details['logo'],
      );
    }

    final updated = List<PortfolioItem>.from(state.portfolio)..add(item);
    final sorted = _sortPortfolio(updated, state.sortOption, state.prices);

    await repository.savePortfolio(sorted);
    emit(state.copyWith(portfolio: sorted, isAdding: false));
    add(RefreshPrices());
  }


  Future<void> _onRemoveAsset(RemoveAsset event, Emitter<PortfolioState> emit) async {
    final updated = state.portfolio.where((item) => item.coinId != event.coinId).toList();
    final sorted = _sortPortfolio(updated, state.sortOption, state.prices);

    await repository.savePortfolio(sorted);
    emit(state.copyWith(portfolio: sorted));
    add(RefreshPrices());
  }

  Future<void> _onRefreshPrices(RefreshPrices event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(isLoading: true));
    final ids = state.portfolio.map((e) => e.coinId).toList();
    final prices = await repository.fetchPrices(ids);

    final sorted = _sortPortfolio(state.portfolio, state.sortOption, prices);
    emit(state.copyWith(prices: prices, portfolio: sorted, isLoading: false));
  }

  void _onSortPortfolio(SortPortfolio event, Emitter<PortfolioState> emit) {
    final sorted = _sortPortfolio(state.portfolio, event.option, state.prices);
    emit(state.copyWith(portfolio: sorted, sortOption: event.option));
  }

  List<PortfolioItem> _sortPortfolio(List<PortfolioItem> portfolio, SortOption option, Map<String, double> prices) {
    final list = List<PortfolioItem>.from(portfolio);

    switch (option) {
      case SortOption.name:
        list.sort((a, b) => a.coinName.toLowerCase().compareTo(b.coinName.toLowerCase()));
        break;
      case SortOption.value:
        list.sort((a, b) {
          final aVal = (prices[a.coinId] ?? 0) * a.quantity;
          final bVal = (prices[b.coinId] ?? 0) * b.quantity;
          return bVal.compareTo(aVal);
        });
        break;
    }

    return list;
  }
}
