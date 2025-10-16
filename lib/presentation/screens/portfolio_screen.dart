import 'package:crypto_portfolio_tracker/app/app_router.dart';
import 'package:crypto_portfolio_tracker/presentation/screens/add_asset_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/portfolio_bloc.dart';
import '../../logic/bloc/portfolio_event.dart';
import '../../logic/bloc/portfolio_state.dart';
import '../widgets/portfolio_card.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Portfolio'),
          actions: [
          PopupMenuButton<SortOption>(
          onSelected: (option) {
    context.read<PortfolioBloc>().add(SortPortfolio(option));
    },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: SortOption.name,
          child: Text("Sort by Name"),
        ),
        const PopupMenuItem(
          value: SortOption.value,
          child: Text("Sort by Value"),
        ),
      ],
      ),
    ],
      ),
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          if (state.isLoading) return const Center(child: CircularProgressIndicator());
          if (state.portfolio.isEmpty) return const Center(child: Text('No assets added'));
          return RefreshIndicator(
            onRefresh: () async => context.read<PortfolioBloc>().add(RefreshPrices()),
            child: ListView.builder(
              itemCount: state.portfolio.length,
              itemBuilder: (context, i) {
                final item = state.portfolio[i];
                final price = state.prices[item.coinId] ?? 0;

                return Dismissible(
                  key: Key(item.coinId),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.redAccent,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    context.read<PortfolioBloc>().add(RemoveAsset(item.coinId));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.coinName} removed from portfolio')),
                    );
                  },
                  child: PortfolioCard(item: item, price: price),
                );
              },
            )

          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRouter.addAsset);

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
