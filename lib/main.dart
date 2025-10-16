import 'package:flutter/material.dart';
import 'app/app.dart';
import 'data/repositories/crypto_repository.dart';
import 'data/services/api_service.dart';
import 'data/local/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = CryptoRepository(ApiService(), LocalStorage());

  runApp(CryptoApp(repository: repository));
}
