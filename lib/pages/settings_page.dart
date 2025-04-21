import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

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