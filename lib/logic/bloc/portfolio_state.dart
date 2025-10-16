import 'package:equatable/equatable.dart';
import '../../data/models/portfolio_model.dart';

enum SortOption { name, value }

class PortfolioState extends Equatable {
  final List<PortfolioItem> portfolio;
  final Map<String, double> prices;
  final bool isLoading;
  final SortOption sortOption;
  final bool isAdding;
  const PortfolioState({
    this.portfolio = const [],
    this.prices = const {},
    this.isAdding = false,
    this.isLoading = false,
    this.sortOption = SortOption.name,
  });

  PortfolioState copyWith({
    List<PortfolioItem>? portfolio,
    Map<String, double>? prices,
    bool? isLoading,
    bool? isAdding,
    SortOption? sortOption,
  }) {
    return PortfolioState(
      portfolio: portfolio ?? this.portfolio,
      prices: prices ?? this.prices,
      isLoading: isLoading ?? this.isLoading,
      isAdding: isAdding ?? this.isAdding,
      sortOption: sortOption ?? this.sortOption,
    );
  }

  @override
  List<Object> get props => [portfolio, prices, isLoading, sortOption];
}
