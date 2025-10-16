import 'package:equatable/equatable.dart';
import '../../data/models/portfolio_model.dart';

abstract class PortfolioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPortfolio extends PortfolioEvent {}
class AddAsset extends PortfolioEvent {
  final PortfolioItem item;
  AddAsset(this.item);
}
class RemoveAsset extends PortfolioEvent {
  final String coinId;
  RemoveAsset(this.coinId);
}
class RefreshPrices extends PortfolioEvent {}

