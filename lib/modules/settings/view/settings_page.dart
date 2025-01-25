import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Notification'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Handle perubahan notifikasi
              },
            ),
          ),
          ListTile(
            title: Text('Bahasa'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Handle perubahan notifikasi
              },
            ),
          ),
          ListTile(
            title: Text('Location'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Handle perubahan notifikasi
              },
            ),
          ),
        ],
      ),
    );
  }
}
