/*
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = true;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Settings',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 20),
        Card(
          color: Colors.grey.shade800,
          child: ListTile(
            title: Text('Dark Mode', style: TextStyle(color: Colors.white)),
            trailing: Switch(
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
              activeColor: Colors.orangeAccent,
            ),
          ),
        ),
        Card(
          color: Colors.grey.shade800,
          child: ListTile(
            title: Text('Notifications', style: TextStyle(color: Colors.white)),
            trailing: Switch(
              value: _notifications,
              onChanged: (value) {
                setState(() {
                  _notifications = value;
                });
              },
              activeColor: Colors.orangeAccent,
            ),
          ),
        ),
        Card(
          color: Colors.grey.shade800,
          child: ListTile(
            title: Text('About', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Navigate to about page
            },
          ),
        ),
        Card(
          color: Colors.grey.shade800,
          child: ListTile(
            title: Text('Help & Support', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Navigate to help page
            },
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Add logout functionality
          },
          child: Text('Log Out'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ],
    );
  }
}
*/

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage your app preferences',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 30),

                // Profile Section
                _buildSectionHeader('Profile'),
                const SizedBox(height: 16),
                _buildProfileCard(),
                const SizedBox(height: 30),

                // App Settings Section
                _buildSectionHeader('App Settings'),
                const SizedBox(height: 16),
                // Notifications
                _buildSettingsCard(
                  icon: Icons.notifications_rounded,
                  iconColor: Colors.blue,
                  title: 'Notifications',
                  subtitle: 'Get notified about new features',
                  trailing: Switch(
                    value: _notifications,
                    onChanged: (value) {
                      setState(() {
                        _notifications = value;
                      });
                    },
                    activeColor: Colors.orangeAccent,
                    activeTrackColor: Colors.orangeAccent.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 14),

                // Security
                _buildSettingsCard(
                  icon: Icons.lock_rounded,
                  iconColor: Colors.green,
                  title: 'App Lock',
                  subtitle: 'Secure your mood data',
                  onTap: () {},
                ),
                const SizedBox(height: 14),

                // User Data
                _buildSettingsCard(
                  icon: Icons.data_usage_rounded,
                  iconColor: Colors.purple,
                  title: 'Your Data',
                  subtitle: 'View or export your data',
                  onTap: () {},
                ),
                const SizedBox(height: 14),

                // Help & Support
                _buildSettingsCard(
                  icon: Icons.support_agent_rounded,
                  iconColor: Colors.teal,
                  title: 'Help & Support',
                  subtitle: 'Get assistance with the app',
                  onTap: () {},
                ),
                const SizedBox(height: 30),

                // About Section
                _buildSectionHeader('About'),
                const SizedBox(height: 16),
                _buildSettingsCard(
                  icon: Icons.info_outline_rounded,
                  iconColor: Colors.amber,
                  title: 'About Mind Space',
                  subtitle: 'Version 1.0.0',
                  onTap: () {},
                ),
                const SizedBox(height: 30),

                // Log Out Button
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add logout functionality
                    },
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.orangeAccent,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.orangeAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                color: Colors.orangeAccent,
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'john.doe@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.orangeAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing ??
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey.shade400,
                      size: 16,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}