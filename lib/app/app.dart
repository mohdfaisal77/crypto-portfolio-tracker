import 'package:crypto_portfolio_tracker/app/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/crypto_repository.dart';
import '../logic/bloc/portfolio_bloc.dart';

import 'app_theme.dart';

class CryptoApp extends StatelessWidget {
  final CryptoRepository repository;
  const CryptoApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PortfolioBloc(repository),
      child: MaterialApp(
        title: 'Crypto Portfolio Tracker',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRouter.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
