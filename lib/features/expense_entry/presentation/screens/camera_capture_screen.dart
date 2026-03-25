import 'dart:async';
import 'dart:io';

import 'package:deduzai/core/domain/models/ocr_result.dart';
import 'package:deduzai/features/expense_entry/data/ocr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CameraCaptureScreen extends ConsumerStatefulWidget {
  const CameraCaptureScreen({super.key});

  @override
  ConsumerState<CameraCaptureScreen> createState() =>
      _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends ConsumerState<CameraCaptureScreen> {
  bool _isProcessing = false;
  Timer? _timeoutTimer;

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  Future<void> _captureFromSource(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 85);
    if (picked == null || !mounted) return;

    final service = ref.read(ocrServiceProvider);

    // Save to app documents dir first
    final savedPath = await service.saveImage(File(picked.path));

    // Spec 2.5 — low quality check
    final lowQuality = await service.isLowQuality(savedPath);
    if (lowQuality && mounted) {
      final retry = await _showLowQualityDialog();
      if (retry ?? false) {
        await _captureFromSource(source);
        return;
      }
      // User chose "Usar assim mesmo" — continue with current image
    }

    await _runOcr(savedPath, service);
  }

  Future<void> _runOcr(String imagePath, OcrService service) async {
    if (!mounted) return;
    setState(() {
      _isProcessing = true;
    });

    // Spec 2.7 — timeout dialog after 15s
    _timeoutTimer = Timer(const Duration(seconds: 15), () {
      if (mounted && _isProcessing) {
        _showTimeoutDialog(imagePath, service);
      }
    });

    try {
      final result = await service.processImage(imagePath);
      _timeoutTimer?.cancel();
      if (mounted) context.pop<OcrResult>(result);
    } on TimeoutException {
      // Handled by the timeout timer callback
    } on Exception catch (e) {
      debugPrint('OCR error: $e');
      _timeoutTimer?.cancel();
      if (mounted) {
        context.pop<OcrResult>(
          OcrResult(status: OcrStatus.failure, imagePath: imagePath),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<bool?> _showLowQualityDialog() {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Foto pode estar com baixa qualidade'),
        content: const Text('Deseja tentar novamente?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Usar assim mesmo'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  Future<void> _showTimeoutDialog(
    String imagePath,
    OcrService service,
  ) async {
    if (!mounted) return;
    final choice = await showDialog<_TimeoutChoice>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Processamento demorou mais que o esperado'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(_TimeoutChoice.wait),
            child: const Text('Aguardar'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(ctx).pop(_TimeoutChoice.fillManually),
            child: const Text('Preencher manualmente'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (choice == _TimeoutChoice.fillManually) {
      setState(() => _isProcessing = false);
      context.pop<OcrResult>(
        OcrResult(status: OcrStatus.failure, imagePath: imagePath),
      );
    }
    // If "Aguardar", keep waiting — the OCR future will eventually resolve
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Capturar Comprovante'),
      ),
      body: _isProcessing ? _buildProcessing() : _buildCapture(),
    );
  }

  Widget _buildProcessing() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 16),
          Text(
            'Lendo comprovante…',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCapture() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Framing overlay guide
        Center(
          child: Container(
            width: 280,
            height: 380,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white54, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Enquadre a nota fiscal',
                style: TextStyle(color: Colors.white54),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _CaptureButton(
              icon: Icons.camera_alt,
              label: 'Fotografar',
              onTap: () => _captureFromSource(ImageSource.camera),
            ),
            _CaptureButton(
              icon: Icons.photo_library_outlined,
              label: 'Usar foto existente',
              onTap: () => _captureFromSource(ImageSource.gallery),
            ),
          ],
        ),
      ],
    );
  }
}

enum _TimeoutChoice { wait, fillManually }

class _CaptureButton extends StatelessWidget {
  const _CaptureButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
