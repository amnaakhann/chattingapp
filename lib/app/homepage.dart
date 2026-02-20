import 'chat_page.dart';
import 'package:chatting_app1/features/component/user_tiles.dart';
import 'package:chatting_app1/models/services/auth/authservice.dart';
import 'package:chatting_app1/core/widgets/my_drawer.dart';
import 'package:chatting_app1/models/services/auth/chat/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatting_app1/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chatting_app1/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider?>(context);
    final UserEntity? providerUser = authProvider?.state.user;
    final fb.User? firebaseUser = _authService.getCurrentUser();

    final userEmail = providerUser?.email ?? firebaseUser?.email ?? '';
    final displayName = providerUser?.displayName ?? firebaseUser?.displayName ?? userEmail;
    final String? photoUrl = providerUser?.photoUrl ?? firebaseUser?.photoURL;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Row(
          children: [
            Text('VikiTalkie',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700)),
            const SizedBox(width: 8),
            Expanded(
                child: Text(displayName,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14),
                    textAlign: TextAlign.right)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: LayoutBuilder(builder: (context, constraints) {
        // On narrow screens stack vertically, otherwise use two-column layout
        final isNarrow = constraints.maxWidth < 700;
        final accountCard = ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 260, minWidth: 180),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        backgroundImage: (photoUrl ?? '').isNotEmpty ? NetworkImage(photoUrl!) : null,
                        child: (photoUrl ?? '').isEmpty ? Text(displayName.isNotEmpty ? displayName[0].toUpperCase() : '?', style: const TextStyle(color: Colors.white, fontSize: 20)) : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(displayName, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(userEmail, style: TextStyle(color: Theme.of(context).colorScheme.primary.withAlpha(200), fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text('Status', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text('Available', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit), label: const Text('Edit Profile')),
                ],
              ),
            ),
          ),
        );

        final contactsCard = Expanded(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(padding: const EdgeInsets.all(8.0), child: _buildUserList(context)),
          ),
        );

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: isNarrow
              ? Column(
                  children: [accountCard, const SizedBox(height: 12), contactsCard],
                )
              : Row(
                  children: [accountCard, const SizedBox(width: 12), contactsCard],
                ),
        );
      }),
    );
  }

  Widget _buildUserList(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data ?? [];
          // filter out current user
          final currentUserEmail = _authService.getCurrentUser()?.email ?? "";
          final otherUsers = data
              .where((u) => (u['email'] ?? '') != currentUserEmail)
              .toList();
          if (otherUsers.isEmpty) {
            return Center(child: Text('No other users found'));
          }
          return ListView(
            children: otherUsers
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    final currentUserEmail = _authService.getCurrentUser()?.email ?? "";
    if ((userData["email"] ?? "") != currentUserEmail) {
      return UserTiles(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverid: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
