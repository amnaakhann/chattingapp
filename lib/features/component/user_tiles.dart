import 'package:flutter/material.dart';

class UserTiles extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTiles({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        elevation: 1,
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(text.isNotEmpty ? text[0].toUpperCase() : '?'),
          ),
          title: Text(text, style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: const Text('Tap to open chat'),
          trailing: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
