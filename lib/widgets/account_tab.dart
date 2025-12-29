import 'package:flutter/material.dart';
import '../models/user.dart';
import '../screens/login_page.dart'; // Make sure to import your login page

class AccountTab extends StatelessWidget {
  final User currentUser;
  final Function(String, String, String, String) onUpdateProfile;
  final VoidCallback onLogout;

  const AccountTab({
    Key? key,
    required this.currentUser,
    required this.onUpdateProfile,
    required this.onLogout, required String userName, required String userEmail, required String userPhone, required String userAddress,
  }) : super(key: key);

  void _showEditProfileDialog(BuildContext context) {
    final nameController = TextEditingController(text: currentUser.name);
    final emailController = TextEditingController(text: currentUser.email);
    final phoneController = TextEditingController(text: currentUser.phone);
    final addressController = TextEditingController(text: currentUser.address);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  enabled: false, // Email cannot be changed
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    addressController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                onUpdateProfile(
                  nameController.text,
                  emailController.text,
                  phoneController.text,
                  addressController.text,
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileInfo(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountOption(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Profile Header
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.red, Colors.redAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Colors.red),
              ),
              const SizedBox(height: 16),
              Text(
                currentUser.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                currentUser.email,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Profile Information Section
        const Text(
          'Profile Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildProfileInfo('Full Name', currentUser.name, Icons.person),
        _buildProfileInfo('Email Address', currentUser.email, Icons.email),
        _buildProfileInfo('Phone Number', currentUser.phone, Icons.phone),
        _buildProfileInfo('Address', currentUser.address, Icons.location_on),

        const SizedBox(height: 24),

        // Edit Profile Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _showEditProfileDialog(context),
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Account Options Section
        const Text(
          'Account Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildAccountOption(Icons.location_on_outlined, 'My Addresses', () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('My Addresses - Coming Soon')),
          );
        }),
        _buildAccountOption(Icons.receipt_outlined, 'Order History', () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order History - Coming Soon')),
          );
        }),
        _buildAccountOption(Icons.favorite_outline, 'My Favorites', () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('My Favorites - Coming Soon')),
          );
        }),
        _buildAccountOption(Icons.payment_outlined, 'Payment Methods', () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment Methods - Coming Soon')),
          );
        }),
        _buildAccountOption(Icons.settings_outlined, 'Settings', () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Settings - Coming Soon')),
          );
        }),
        _buildAccountOption(Icons.help_outline, 'Help & Support', () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Help & Support - Coming Soon')),
          );
        }),

        const SizedBox(height: 24),

        // Logout Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext); // Close dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext); // Close dialog

                          // ✅ Correct logout navigation
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
