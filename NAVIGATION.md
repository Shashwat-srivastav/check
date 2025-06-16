# Navigation Routes Documentation

## Available Routes

This document describes the navigation routes available in the Phantom Wallet app.

### Route Constants

All routes are defined in `main.dart` using the `AppRoutes` class:

```dart
class AppRoutes {
  static const String home = '/home';
  static const String send = '/send';
  static const String selectToken = '/select-token';
  static const String enterAmount = '/enter-amount';
  static const String swap = '/swap';
  static const String profile = '/profile';
  static const String search = '/search';
}
```

### Navigation Flow

1. **HomePage (`/home`)** - Main dashboard
   - Navigate to Send: `Navigator.pushNamed(context, '/send')`
   - Navigate to Swap: `Navigator.pushNamed(context, '/swap')`
   - Navigate to Search: `Navigator.pushNamed(context, '/search')`
   - Navigate to Profile: `Navigator.pushNamed(context, '/profile')`

2. **SendPage (`/send`)** - Send crypto to recipients
   - Navigate to Token Selection: `Navigator.pushNamed(context, '/select-token')`

3. **SelectTokenPage (`/select-token`)** - Choose which token to send
   - Navigate to Amount Entry with arguments:
   ```dart
   Navigator.pushNamed(
     context,
     '/enter-amount',
     arguments: {
       'selectedToken': selectedToken,
       'recipientAddress': recipientAddress,
     },
   );
   ```

4. **EnterAmountPage (`/enter-amount`)** - Enter amount to send
   - Receives arguments: `selectedToken` and `recipientAddress`

5. **SwapPage (`/swap`)** - Swap between tokens

6. **EditAccountPage (`/profile`)** - Account settings and management

7. **SearchPage (`/search`)** - Search for tokens, people, sites

### Navigation Helper

The `NavigationHelper` class provides convenient methods for complex navigation:

```dart
NavigationHelper.navigateToEnterAmount(
  context,
  selectedToken: token,
  recipientAddress: address,
);
```

### Usage Examples

#### Simple Navigation
```dart
// Navigate to send page
Navigator.pushNamed(context, '/send');

// Navigate to profile
Navigator.pushNamed(context, '/profile');
```

#### Navigation with Arguments
```dart
// Navigate to enter amount page with token data
Navigator.pushNamed(
  context,
  '/enter-amount',
  arguments: {
    'selectedToken': selectedToken,
    'recipientAddress': '@username (0x1234...5678)',
  },
);
```

### Back Navigation

All pages support standard back navigation using:
```dart
Navigator.pop(context);
```

The app bar back buttons are properly configured to use `Navigator.pop(context)`.
