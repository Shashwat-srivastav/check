

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phantom/profile.dart';
import 'package:phantom/searchpage.dart';
import 'package:phantom/sendpage.dart';
import 'package:phantom/swappage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: Row(
          children: [
            const SizedBox(width: 16),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF4A90E2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.star,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const EditAccountPage()));
            // Navigate to account details or profile page
          },
          child: const Text(
            'Account 1',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
            onPressed: () {},
          ),          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Welcome Section
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Welcome Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 73, 72, 72),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              '^ ^',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B5CF6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '8m',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Stars
                        const Positioned(
                          top: 10,
                          left: 25,
                          child: Icon(Icons.star, color: Colors.white, size: 8),
                        ),
                        const Positioned(
                          top: 20,
                          right: 8,
                          child: Icon(Icons.star, color: Colors.white, size: 6),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Welcome, @FertilePeach394',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 0),
                  const Text(
                    'Add Solana (SOL) to your wallet to get started',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Buy SOL Button
                  Container(
                    width: double.infinity,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Buy SOL with cash',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 42,
                    decoration: BoxDecoration(

                      color: Color.fromARGB(255, 84, 84, 84),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Transfer crypto',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
              ),
              
            ),
            // Action Buttons
            Container(
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(Icons.qr_code, 'Receive'),                  GestureDetector(
                    onTap: () {
                      // Handle send action
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SendPage()));
                    },
                    child: _buildActionButton(Icons.send, 'Send'),
                  ),
                  _buildActionButton(Icons.swap_horiz, 'Swap'),
                  _buildActionButton(Icons.attach_money, 'Buy'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Liquid Stake Banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B5CF6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.layers,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Liquid stake PSOL to earn up to 9% APY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Tokens Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Tokens',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Text(
                        'Collectibles',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.more_horiz, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTokenItem(
                    'Bitcoin',
                    'Taproot',
                    '0 BTC',
                    Icons.currency_bitcoin,
                    const Color(0xFFFF9500),
                  ),
                  _buildTokenItem(
                    'Bitcoin',
                    'Native Segwit',
                    '0 BTC',
                    Icons.currency_bitcoin,
                    const Color(0xFFFF9500),
                  ),
                  _buildTokenItem(
                    'Ethereum',
                    '0 ETH',
                    '',
                    Icons.diamond,
                    const Color(0xFF627EEA),
                  ),
                  _buildTokenItem(
                    'Ethereum',
                    '0 ETH',
                    '',
                    Icons.diamond,
                    const Color(0xFF627EEA),
                  ),
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
              icon: const Icon(Icons.home, color: Color(0xFF8B5CF6), size: 28),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.swap_horiz, color: Colors.grey, size: 28),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>SwapPage()),);
              },
            ),
            IconButton(
              icon: const Icon(Icons.history, color: Colors.grey, size: 28),
              onPressed: () {},
            ),            IconButton(
              icon: const Icon(Icons.search, color: Colors.grey, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(7),
          width: 90,
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.deepPurpleAccent,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Color.fromARGB(255, 157, 152, 152),
                  fontSize: 12,
                  // fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        
      ],
    );
  }

  Widget _buildTokenItem(String name, String subtitle, String balance, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),

      decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (subtitle.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        color: Color.fromARGB(255, 87, 86, 86),
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
                
                Text(
                  balance.isEmpty ? '0 ETH' : balance,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  '\$0.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '\$0.00',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
