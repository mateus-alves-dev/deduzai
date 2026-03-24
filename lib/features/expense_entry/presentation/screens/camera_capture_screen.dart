import 'package:flutter/material.dart';

class CameraCaptureScreen extends StatelessWidget {
  const CameraCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Capturar Comprovante')),
      body: const Center(child: Text('Câmera')),
    );
  }
}
