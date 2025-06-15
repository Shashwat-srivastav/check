import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class EnterAmountPage extends StatefulWidget {
  final Token selectedToken;
  final String recipientAddress;

  const EnterAmountPage({
    Key? key,
    required this.selectedToken,
    required this.recipientAddress,
  }) : super(key: key);

  @override
  State<EnterAmountPage> createState() => _EnterAmountPageState();
}

class _EnterAmountPageState extends State<EnterAmountPage> {
  final TextEditingController _amountController = TextEditingController();
  String _usdValue = '~\$0.00';
  bool _isNextEnabled = false;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final amount = _amountController.text;
    setState(() {
      _isNextEnabled = amount.isNotEmpty && double.tryParse(amount) != null;
      // Mock USD conversion - in real app, this would be fetched from an API
      if (amount.isNotEmpty && double.tryParse(amount) != null) {
        final value = double.parse(amount);
        final usdAmount = value * 2000; // Mock ETH price
        _usdValue = '~\$${usdAmount.toStringAsFixed(2)}';
      } else {
        _usdValue = '~\$0.00';
      }
    });
  }

  String _formatAddress(String address) {
    if (address.length > 10) {
      return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
    }
    return address;
  }

  void _setMaxAmount() {
    // In a real app, this would set the maximum available balance
    _amountController.text = '0.5'; // Mock max amount
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
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Enter Amount',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _isNextEnabled ? _onNextPressed : null,
            child: Text(
              'Next',
              style: TextStyle(
                color: _isNextEnabled ? Colors.white : const Color(0xFF8E8E93),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Recipient Section
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'To:',
                        style: TextStyle(
                          color: Color(0xFF8E8E93),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '@surender (${_formatAddress(widget.recipientAddress)})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Edit recipient
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Color(0xFF8E8E93),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          // Amount Input Section
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Amount Input
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Container(
                      constraints: const BoxConstraints(minWidth: 50),
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*')),
                          ],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: const InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Color(0xFF8E8E93),
                              fontSize: 48,
                              fontWeight: FontWeight.w300,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.selectedToken.symbol,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A3C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.swap_vert,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // USD Value
                Text(
                  _usdValue,
                  style: const TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Section
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Available Balance
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Available To Send',
                      style: TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: _setMaxAmount,
                      child: const Text(
                        'Max',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '0 ${widget.selectedToken.symbol}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Next Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isNextEnabled ? _onNextPressed : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isNextEnabled
                          ? const Color(0xFF6366F1)
                          : const Color(0xFF3A3A3C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onNextPressed() {
    // Navigate to next page (e.g., transaction confirmation)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: const Text(
          'Transaction Details',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount: ${_amountController.text} ${widget.selectedToken.symbol}',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Value: $_usdValue',
              style: const TextStyle(color: Color(0xFF8E8E93)),
            ),
            Text(
              'To: @surender',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Proceed with transaction
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

// Example usage with navigation from SelectTokenPage
class SelectTokenPage extends StatelessWidget {
  const SelectTokenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Token',
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTokenItem(
            context,
            Token(
              name: 'Ethereum',
              symbol: 'ETH',
              balance: '0 ETH',
              iconPath: 'Ξ',
              iconColor: const Color(0xFF627EEA),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenItem(BuildContext context, Token token) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      child: Material(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EnterAmountPage(
                  selectedToken: token,
                  recipientAddress: '0x1dbC...9C1b',
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        token.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
