import 'package:flutter/material.dart';

class AnnualSummaryScreen extends StatelessWidget {
  const AnnualSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo Anual')),
      body: const Center(child: Text('Resumo por categoria')),
    );
  }
}
