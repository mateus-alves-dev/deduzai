import 'package:flutter/material.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gastos')),
      body: const Center(child: Text('Lista de gastos')),
    );
  }
}
