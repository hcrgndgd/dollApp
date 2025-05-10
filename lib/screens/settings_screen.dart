import 'package:flutter/material.dart';
import 'package:wardrobe_app/screens/changePassword_screen.dart';
import 'package:wardrobe_app/screens/userAccount_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true; // Toggle durumu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple.shade800,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Hesap Bilgileri'),
            trailing: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountScreen(),
                  ),
                );
              },
            ),
          ),
          const Divider(color: Colors.black54),
          ListTile(
            title: const Text('Şifremi Değiştir'),
            trailing: IconButton(
              icon: const Icon(Icons.lock),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen(),
                  ),
                );
              },
            ),
          ),
                    const Divider(color: Colors.black54),
              SwitchListTile(
            title: const Text('Bildirimler'),
            value: notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                notificationsEnabled = value;
              });
              // Buraya bildirim ayarlarını kaydetme işlemi eklenebilir
            },
          ),
          const Divider(color: Colors.black54),
          ListTile(
            title: const Text('Çıkış Yap'),
            trailing: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                // Çıkış yapma işlemi gelecek
              },
            ),
          ),
          const Divider(color: Colors.black87),
        ],
      ),
    );
  }
}
