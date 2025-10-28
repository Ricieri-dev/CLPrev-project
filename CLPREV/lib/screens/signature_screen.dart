import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  final String title;

  SignatureScreen({required this.title});

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveSignature,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: _controller,
              height: 300,
              backgroundColor: Colors.grey[200]!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _controller.clear(),
                  child: Text('Limpar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                ElevatedButton(
                  onPressed: _saveSignature,
                  child: Text('Confirmar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveSignature() async {
    if (_controller.isEmpty) {
      return;
    }

    final bytes = await _controller.toPngBytes();
    if (bytes == null) {
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final filePath = p.join(
      directory.path,
      'signature_${DateTime.now().millisecondsSinceEpoch}.png',
    );

    final file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);

    if (!mounted) {
      return;
    }

    Navigator.pop(context, file.path);
  }
}
