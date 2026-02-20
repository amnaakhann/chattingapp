import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';

class HomePageClean extends StatelessWidget {
  final UserEntity? user;
  final VoidCallback onSignOut;

  const HomePageClean({Key? key, this.user, required this.onSignOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surfaceContainerHighest;
    final leftBg = surface.withAlpha((0.06 * 255).toInt());

    return Scaffold(
      appBar: AppBar(title: const Text('VikiTalkie')),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(user?.displayName ?? 'Guest'),
                accountEmail: Text(user?.email ?? ''),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: user?.photoUrl != null ? NetworkImage(user!.photoUrl!) : null,
                  child: user?.photoUrl == null ? const Icon(Icons.person) : null,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign out'),
                onTap: onSignOut,
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          // Left column: small account detail area
          Container(
            width: 260,
            color: leftBg,
            child: Column(
              children: [
                const SizedBox(height: 16),
                CircleAvatar(
                  radius: 36,
                  backgroundImage: user?.photoUrl != null ? NetworkImage(user!.photoUrl!) : null,
                  child: user?.photoUrl == null ? const Icon(Icons.person, size: 36) : null,
                ),
                const SizedBox(height: 8),
                Text(user?.displayName ?? 'Guest', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Contacts'),
                ),
                // ... contact list placeholder
                Expanded(
                  child: ListView.builder(
                    itemCount: 12,
                    itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(child: Text('U${index + 1}')),
                      title: Text('Contact ${index + 1}'),
                      subtitle: const Text('Last message preview'),
                      onTap: () {},
                    ),
                  ),
                )
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          // Chat area
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.centerLeft,
                  child: const Text('Chats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(child: Text('C${index + 1}')),
                      title: Text('Chat ${index + 1}'),
                      subtitle: const Text('Message preview...'),
                      onTap: () {},
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    children: [
                      Expanded(child: TextField(decoration: InputDecoration(hintText: 'Type a message'))),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.send, color: Colors.blue)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
