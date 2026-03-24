import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.archive_outlined),
            title: const Text('Comprovantes arquivados'),
            subtitle: const Text('Comprovantes de gastos excluídos'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/receipts/archived'),
          ),
        ],
      ),
    );
  }
}
