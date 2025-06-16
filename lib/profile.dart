import 'package:flutter/material.dart';

class EditAccountPage extends StatelessWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
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
          'Edit Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Profile Avatar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF4A90E2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.star,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            // Account Name (Static Display)
            const Text(
              'Account 1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 40),
            // Settings List
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSettingsItem(
                    icon: Icons.security,
                    title: 'Show Secret Recovery Phrase',
                    onTap: () {
                      // Handle showing recovery phrase
                    },
                  ),
                  _buildDivider(),
                  _buildSettingsItem(
                    icon: Icons.key,
                    title: 'Show Private Key',
                    onTap: () {
                      // Handle showing private key
                    },
                  ),
                  _buildDivider(),
                  _buildSettingsItem(
                    icon: Icons.edit,
                    title: 'Rename Account',
                    onTap: () {
                      // Handle renaming account
                    },
                  ),
                  _buildDivider(),
                  _buildSettingsItem(
                    icon: Icons.delete,
                    title: 'Remove Account',
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: () {
                      // Handle removing account
                      _showRemoveAccountDialog(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Additional Settings
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSettingsItem(
                    icon: Icons.copy,
                    title: 'Copy Address',
                    onTap: () {
                      // Handle copying address
                    },
                  ),
                  _buildDivider(),
                  _buildSettingsItem(
                    icon: Icons.qr_code,
                    title: 'Show QR Code',
                    onTap: () {
                      // Handle showing QR code
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? Colors.white,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: iconColor ?? const Color(0xFF8E8E93),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.only(left: 56),
      color: const Color(0xFF3A3A3C),
    );
  }

  void _showRemoveAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          title: const Text(
            'Remove Account',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to remove this account? This action cannot be undone.',
            style: TextStyle(color: Color(0xFF8E8E93)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Handle account removal
              },
              child: const Text(
                'Remove',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
