import 'package:flutter/material.dart';
import 'package:phantom/amount.dart' as AmountPage;

class Token {
  final String name;
  final String symbol;
  final String balance;
  final String iconPath;
  final Color iconColor;
  final String? badge;

  Token({
    required this.name,
    required this.symbol,
    required this.balance,
    required this.iconPath,
    required this.iconColor,
    this.badge,
  });
}

class SelectTokenPage extends StatefulWidget {
  const SelectTokenPage({Key? key}) : super(key: key);

  @override
  State<SelectTokenPage> createState() => _SelectTokenPageState();
}

class _SelectTokenPageState extends State<SelectTokenPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Token> _filteredTokens = [];

  final List<Token> _allTokens = [
    Token(
      name: 'Bitcoin',
      symbol: 'BTC',
      balance: '0 BTC',
      iconPath: '₿',
      iconColor: const Color(0xFFF7931A),
      badge: 'Taproot',
    ),
    Token(
      name: 'Bitcoin',
      symbol: 'BTC',
      balance: '0 BTC',
      iconPath: '₿',
      iconColor: const Color(0xFFF7931A),
      badge: 'Native Segwit',
    ),
    Token(
      name: 'Ethereum',
      symbol: 'ETH',
      balance: '0 ETH',
      iconPath: 'Ξ',
      iconColor: const Color(0xFF627EEA),
    ),
    Token(
      name: 'Ethereum',
      symbol: 'ETH',
      balance: '0 ETH',
      iconPath: 'Ξ',
      iconColor: const Color(0xFF627EEA),
    ),
    Token(
      name: 'Polygon',
      symbol: 'POL',
      balance: '0 POL',
      iconPath: '⬟',
      iconColor: const Color(0xFF8247E5),
    ),
    Token(
      name: 'Solana',
      symbol: 'SOL',
      balance: '0 SOL',
      iconPath: 'S',
      iconColor: const Color(0xFF14F195),
    ),
    Token(
      name: 'Sui',
      symbol: 'SUI',
      balance: '0 SUI',
      iconPath: 'S',
      iconColor: const Color(0xFF4DA2FF),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filteredTokens = _allTokens;
    _searchController.addListener(_filterTokens);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTokens() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTokens = _allTokens.where((token) {
        return token.name.toLowerCase().contains(query) ||
            token.symbol.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Token',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3C),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF8E8E93),
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          // Token List
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Dismiss keyboard when tapping outside
                FocusScope.of(context).unfocus();
                
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredTokens.length,
                itemBuilder: (context, index) {
                  final token = _filteredTokens[index];
                  return _buildTokenItem(token);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenItem(Token token) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      child: Material(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),          onTap: () {
            // Navigate to EnterAmountPage with selected token
            Navigator.push(
              context,
              MaterialPageRoute(                builder: (context) => AmountPage.EnterAmountPage(
                  selectedToken: AmountPage.Token(
                    name: token.name,
                    symbol: token.symbol,
                    balance: token.balance,
                    iconPath: token.iconPath,
                    iconColor: token.iconColor,
                    badge: token.badge,
                  ),
                  recipientAddress: '', // You can pass actual recipient address here
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Token Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: token.iconColor,
                  ),
                  child: Center(
                    child: Text(
                      token.iconPath,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Token Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            token.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (token.badge != null) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3A3A3C),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                token.badge!,
                                style: const TextStyle(
                                  color: Color(0xFF8E8E93),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        token.balance,
                        style: const TextStyle(
                          color: Color(0xFF8E8E93),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
