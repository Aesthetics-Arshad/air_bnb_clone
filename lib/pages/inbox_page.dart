import 'package:flutter/material.dart';
import '../app_state.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inbox')),
      body: ValueListenableBuilder<List<Message>>(
        valueListenable: AppState.messages,
        builder: (_, list, __) {
          if (list.isEmpty) {
            return const Center(child: Text('Your messages will appear here.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final m = list[i];
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.home)),
                title: Text(m.listingTitle),
                subtitle: Text(m.text),
                trailing: Text(
                  '${m.timestamp.hour.toString().padLeft(2, '0')}:${m.timestamp.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
