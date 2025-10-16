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
  }

  Future<void> _onLoadPortfolio(LoadPortfolio event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    final data = await repository.loadPortfolio();
    emit(state.copyWith(portfolio: data, isLoading: false));
    add(RefreshPrices());
  }

  Future<void> _onAddAsset(AddAsset event, Emitter emit) async {
    final updated = List<PortfolioItem>.from(state.portfolio)..add(event.item);
    await repository.savePortfolio(updated);
    emit(state.copyWith(portfolio: updated));
    add(RefreshPrices());
  }

  Future<void> _onRemoveAsset(RemoveAsset event, Emitter emit) async {
    final updated =
    state.portfolio.where((item) => item.coinId != event.coinId).toList();
    await repository.savePortfolio(updated);
    emit(state.copyWith(portfolio: updated));
    add(RefreshPrices());
  }

  Future<void> _onRefreshPrices(RefreshPrices event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    final ids = state.portfolio.map((e) => e.coinId).toList();
    final prices = await repository.fetchPrices(ids);
    emit(state.copyWith(prices: prices, isLoading: false));
  }
}
