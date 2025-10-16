import 'package:equatable/equatable.dart';
import '../../data/models/portfolio_model.dart';
import 'portfolio_state.dart';

abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object?> get props => [];
}

class LoadPortfolio extends PortfolioEvent {}

class AddAsset extends PortfolioEvent {
  final PortfolioItem item;
  const AddAsset(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveAsset extends PortfolioEvent {
  final String coinId;
  const RemoveAsset(this.coinId);

  @override
  List<Object?> get props => [coinId];
}

class RefreshPrices extends PortfolioEvent {}

class SortPortfolio extends PortfolioEvent {
  final SortOption option;
  const SortPortfolio(this.option);

  @override
  List<Object?> get props => [option];
}
