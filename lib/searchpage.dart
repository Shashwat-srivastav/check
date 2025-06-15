import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = _allItems
            .where((item) => 
                item.name.toLowerCase().contains(query) ||
                item.symbol.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: const InputDecoration(
              hintText: 'Search tokens, NFTs, and more...',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: _searchResults.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return _buildSearchResultItem(result);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isEmpty
                ? 'Start typing to search'
                : 'No results found',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(SearchResult result) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: result.iconColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              result.icon,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text(
          result.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          result.subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        trailing: result.type == SearchResultType.token
            ? const Text(
                '\$0.00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            : null,
        onTap: () {
          // Handle result selection
        },
      ),
    );
  }

  static final List<SearchResult> _allItems = [
    SearchResult(
      name: 'Bitcoin',
      symbol: 'BTC',
      subtitle: 'Cryptocurrency',
      icon: '₿',
      iconColor: const Color(0xFFFF9500),
      type: SearchResultType.token,
    ),
    SearchResult(
      name: 'Ethereum',
      symbol: 'ETH',
      subtitle: 'Cryptocurrency',
      icon: 'Ξ',
      iconColor: const Color(0xFF627EEA),
      type: SearchResultType.token,
    ),
    SearchResult(
      name: 'Solana',
      symbol: 'SOL',
      subtitle: 'Cryptocurrency',
      icon: 'S',
      iconColor: const Color(0xFF8B5CF6),
      type: SearchResultType.token,
    ),
    SearchResult(
      name: 'USDC',
      symbol: 'USDC',
      subtitle: 'Stablecoin',
      icon: '\$',
      iconColor: const Color(0xFF2775CA),
      type: SearchResultType.token,
    ),
  ];
}

enum SearchResultType { token, nft, contact }

class SearchResult {
  final String name;
  final String symbol;
  final String subtitle;
  final String icon;
  final Color iconColor;
  final SearchResultType type;

  SearchResult({
    required this.name,
    required this.symbol,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.type,
  });
}
