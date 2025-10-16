import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String text;
  const LoadingWidget({super.key, this.text = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 12),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
