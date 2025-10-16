import 'dart:async';
import 'package:crypto_portfolio_tracker/app/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/portfolio_bloc.dart';
import '../../logic/bloc/portfolio_event.dart';
import 'portfolio_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      context.read<PortfolioBloc>().add(LoadPortfolio());
      Navigator.pushReplacementNamed(context, AppRouter.portfolio);

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.currency_bitcoin, size: 80, color: Colors.yellow),
              SizedBox(height: 20),
              Text(
                "Crypto Portfolio",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
