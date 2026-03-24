import 'package:flutter/material.dart';

class ReceiptViewerScreen extends StatelessWidget {
  const ReceiptViewerScreen({required this.expenseId, super.key});

  final String expenseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comprovante')),
      body: const Center(child: Text('Visualizador de comprovante')),
    );
  }
}
