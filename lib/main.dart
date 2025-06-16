import 'package:flutter/material.dart';

import 'homepage.dart';
import 'sendpage.dart';
import 'send1page.dart' as TokenSelection;
import 'amount.dart' as AmountPage;
import 'swappage.dart';
import 'profile.dart';
import 'searchpage.dart';

// Route constants
class AppRoutes {
  static const String home = '/home';
  static const String send = '/send';
  static const String selectToken = '/select-token';
  static const String enterAmount = '/enter-amount';
  static const String swap = '/swap';
  static const String profile = '/profile';
  static const String search = '/search';
}

// Navigation helper class
class NavigationHelper {
  static void navigateToEnterAmount(
    BuildContext context, {
    required AmountPage.Token selectedToken,
    required String recipientAddress,
  }) {
    Navigator.pushNamed(
      context,
      AppRoutes.enterAmount,
      arguments: {
        'selectedToken': selectedToken,
        'recipientAddress': recipientAddress,
      },
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phantom Wallet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.send: (context) => const SendPage(),
        AppRoutes.selectToken: (context) => const TokenSelection.SelectTokenPage(),
        AppRoutes.enterAmount: (context) {
          // Get arguments passed to this route
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return AmountPage.EnterAmountPage(
            selectedToken: args?['selectedToken'] ?? AmountPage.Token(
              name: 'Ethereum',
              symbol: 'ETH',
              balance: '0 ETH',
              iconPath: 'Ξ',
              iconColor: const Color(0xFF627EEA),
            ),
            recipientAddress: args?['recipientAddress'] ?? '0x1dbC...9C1b',
          );
        },
        AppRoutes.swap: (context) => const SwapPage(),
        AppRoutes.profile: (context) => const EditAccountPage(),
        AppRoutes.search: (context) => const SearchPage(),
      },
    );
  }
}





