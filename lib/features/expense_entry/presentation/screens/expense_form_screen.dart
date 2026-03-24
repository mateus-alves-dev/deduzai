import 'package:flutter/material.dart';

class ExpenseFormScreen extends StatelessWidget {
  const ExpenseFormScreen({super.key, this.expenseId});

  final String? expenseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(expenseId != null ? 'Editar Gasto' : 'Novo Gasto'),
      ),
      body: const Center(child: Text('Formulário de gasto')),
    );
  }
}
