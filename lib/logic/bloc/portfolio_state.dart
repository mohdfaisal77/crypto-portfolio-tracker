import 'package:equatable/equatable.dart';
import '../../data/models/portfolio_model.dart';

class PortfolioState extends Equatable {
  final List<PortfolioItem> portfolio;
  final Map<String, double> prices;
  final bool isLoading;
  final String? error;

  const PortfolioState({
    this.portfolio = const [],
    this.prices = const {},
    this.isLoading = false,
    this.error,
  });

  PortfolioState copyWith({
    List<PortfolioItem>? portfolio,
    Map<String, double>? prices,
    bool? isLoading,
    String? error,
  }) {
    return PortfolioState(
      portfolio: portfolio ?? this.portfolio,
      prices: prices ?? this.prices,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [portfolio, prices, isLoading, error];
}
