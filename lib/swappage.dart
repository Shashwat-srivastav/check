import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SwapPage extends StatefulWidget {
  const SwapPage({Key? key}) : super(key: key);

  @override
  State<SwapPage> createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  final TextEditingController _payAmountController = TextEditingController();
  final TextEditingController _receiveAmountController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _payAmountController.addListener(_onPayAmountChanged);
  }

  @override
  void dispose() {
    _payAmountController.dispose();
    _receiveAmountController.dispose();
    super.dispose();
  }

  void _onPayAmountChanged() {
    // Mock conversion rate (1 SOL = 0.5 USDC for demo)
    final payAmount = double.tryParse(_payAmountController.text) ?? 0;
    final receiveAmount = payAmount * 0.5;
    _receiveAmountController.text = receiveAmount > 0 ? receiveAmount.toStringAsFixed(6) : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Swap Tokens',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Swap Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // You Pay Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,                      children: [
                        const Text(
                          'You Pay',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _payAmountController,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                ],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: const InputDecoration(
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3A3A3A),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF8B5CF6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'S',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'SOL',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [
                            IconButton(
                              icon: const Icon(Icons.swap_vert, color: Colors.grey, size: 16),
                              onPressed: () {},
                            ),
                            const Spacer(),
                            const Text(
                              '0 SOL',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Swap Icon
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.swap_vert,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  // You Receive Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,                      children: [
                        const Text(
                          'You Receive',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _receiveAmountController,
                                readOnly: true, // Auto-calculated based on pay amount
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: const InputDecoration(
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3A3A3A),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2775CA),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '\$',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'USDC',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '0 USDC',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Trending Tokens Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Trending Tokens',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        '24h Rank',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_upward,
                        color: Colors.grey,
                        size: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Token List
                  ...trendingTokens.map((token) => _buildTokenItem(token)),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1A),
          border: Border(
            top: BorderSide(color: Color(0xFF2A2A2A), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.grey, size: 28),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.swap_horiz, color: Color(0xFF8B5CF6), size: 28),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.history, color: Colors.grey, size: 28),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.grey, size: 28),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenItem(TokenData token) {
    final isPositive = token.changePercent >= 0;
    final changeColor = isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    return Container(
     margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // Token Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
       
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: token.icon,
            ),
          ),
          const SizedBox(width: 12),
          // Token Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
              
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    token.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    token.marketCap,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Price and Change
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                token.price,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${isPositive ? '+' : ''}${token.changePercent.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: changeColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static final List<TokenData> trendingTokens = [
    TokenData(
      name: 'maxi',
      marketCap: '\$392K MC',
      price: '\$0.00042304',
      changePercent: 8549.89,
      icon: Container(
        color: const Color(0xFFD2691E),
        child: const Center(
          child: Text(
            'M',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    TokenData(
      name: 'PEACEGUY',
      marketCap: '\$1.6M MC',
      price: '\$0.00165859',
      changePercent: 12.88,
      icon: Container(
        color: const Color(0xFF87CEEB),
        child: const Center(
          child: Text(
            'P',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    TokenData(
      name: 'Fartcat',
      marketCap: '\$5.6M MC',
      price: '\$0.0052083',
      changePercent: 4524.75,
      icon: Container(
        color: const Color(0xFF2F2F2F),
        child: const Center(
          child: Text(
            'F',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    TokenData(
      name: 'QQQ',
      marketCap: '\$358K MC',
      price: '\$0.0003637',
      changePercent: 13.13,
      icon: Container(
        color: const Color(0xFF1E90FF),
        child: const Center(
          child: Text(
            'Q',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    TokenData(
      name: 'RGB',
      marketCap: '\$4.1M MC',
      price: '\$0.00363339',
      changePercent: 145.04,
      icon: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.green, Colors.blue],
          ),
        ),
        child: const Center(
          child: Text(
            'R',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    TokenData(
      name: 'WLFI',
      marketCap: '\$2.3M MC',
      price: '\$0.00216434',
      changePercent: 608.97,
      icon: Container(
        color: const Color(0xFF8B4513),
        child: const Center(
          child: Text(
            'W',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    TokenData(
      name: 'aura',
      marketCap: '\$189M MC',
      price: '\$0.21',
      changePercent: 11.37,
      icon: Container(
        color: const Color(0xFF6A5ACD),
        child: const Center(
          child: Text(
            'A',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    TokenData(
      name: 'retire',
      marketCap: '\$3.7M MC',
      price: '\$0.00347512',
      changePercent: 179.37,
      icon: Container(
        color: const Color(0xFF4682B4),
        child: const Center(
          child: Text(
            'R',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  ];
}

class TokenData {
  final String name;
  final String marketCap;
  final String price;
  final double changePercent;
  final Widget icon;

  TokenData({
    required this.name,
    required this.marketCap,
    required this.price,
    required this.changePercent,
    required this.icon,
  });
}