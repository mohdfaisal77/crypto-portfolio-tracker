## Crypto Portfolio Tracker ##

This crypto portfolio app is designed to help users efficiently manage and track their cryptocurrency investments. Its primary purpose is to aggregate data from multiple exchanges and wallets into one centralized platform, enabling users to monitor real-time asset values, track profits and losses, and analyze portfolio performance.

App Setup Steps
-------------------

## 1. Prerequisites

Install Flutter SDK (latest stable version) - https://docs.flutter.dev/install/archive

Install Dart SDK (comes with Flutter) - https://dart.dev/get-dart

Set up your IDE (Android Studio, VS Code or IntelliJ) with Flutter and Dart plugins

## 2. Clone the repository

Go to bash and Run Below commands
-------------------
git clone https://github.com/mohdfaisal77/crypto-portfolio-tracker.git
cd crypto_portfolio_tracker

## 3. Install dependencies

Go to bash and Run Below commands
-------------------
flutter pub get

## 4. Run the app

Connect your emulator or physical device
Start the app with:

Within the terminal of youre app run below command(in VS code or Android Studio)
-----------------
flutter run

## Running the Application ##
-------------------------------------------------

Use flutter run to build and deploy the app on your connected device or emulator.
The app supports Android, iOS, and can be extended to web/desktop platforms.
To change or add assets, use the Add button.
Use the sort menu in the app bar to sort portfolio by coin name or holding value.
Prices and coin logos are fetched dynamically from the CoinGecko API.

## Recorded Video ##
--------------------
A recorded video demonstration of the implemented sorting feature and portfolio functionalities is publicly available here:
https://youtube.com/shorts/xu2yVqadRnk

## Architectural Choices ##
--------------------------------

State Management: Uses the Flutter Bloc (flutter_bloc) for predictable state management and separation of business logic and UI.
Data Layer: Abstracted through repository and service classes (CryptoRepository and ApiService) to separate API calls and local storage.
API Integration: CoinGecko public API to fetch cryptocurrency prices, logos, and metadata.
Sorting Logic: Incorporated within Bloc to keep UI reactive and decoupled from state management.
Asynchronous Operations: Handled gracefully with async/await and event-driven Bloc listeners.
Image Caching: Uses network image caching for performance and smooth UI experience.


## Third-Party Libraries Used ##
--------------------------------------
flutter_bloc: For Bloc state management and event handling.
http: For REST API calls to CoinGecko.
equatable: To simplify state comparison in Bloc.
cached_network_image: To efficiently load and cache crypto logos in UI.
intl: For formatting currency and numbers

You can find all dependencies in the pubspec.yaml file.