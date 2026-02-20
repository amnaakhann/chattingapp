import '../auth/authservice.dart';
import 'settingpage.dart';
import 'package:flutter/material.dart';
import '../theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService().getCurrentUser();
    final displayName = user?.displayName ?? user?.email ?? 'Guest';
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            accountName: Text(displayName),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: Builder(
              builder: (context) {
                final photoUrl = user?.photoURL ?? '';
                return CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  backgroundImage: photoUrl.isNotEmpty
                      ? NetworkImage(photoUrl)
                      : null,
                  child: photoUrl.isEmpty
                      ? Text(
                          displayName.isNotEmpty
                              ? displayName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(color: Colors.white),
                        )
                      : null,
                );
              },
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settingpage()),
              );
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: logout,
                    child: const Text('Logout'),
                  ),
                ),
                const SizedBox(width: 12),
                Consumer<ThemeProvider>(
                  builder: (context, tp, _) {
                    return Switch.adaptive(
                      value: tp.isdarkmode,
                      onChanged: (v) => tp.toggletheme(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
