import 'package:crypto_portfolio_tracker/presentation/screens/add_asset_screen.dart';
import 'package:crypto_portfolio_tracker/presentation/screens/portfolio_screen.dart';
import 'package:crypto_portfolio_tracker/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';


class AppRouter {
  static const String splash = '/';
  static const String portfolio = '/portfolio';
  static const String addAsset = '/add-asset';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case portfolio:
        return MaterialPageRoute(builder: (_) => const PortfolioScreen());

      case addAsset:
        return MaterialPageRoute(builder: (_) => const AddAssetScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 | Page Not Found')),
          ),
        );
    }
  }
}
