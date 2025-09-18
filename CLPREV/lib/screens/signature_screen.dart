import 'package:flutter/material.dart';
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
            onPressed: () {
              if (_controller.isNotEmpty) {
                // Retornar a assinatura
                _controller.toPngBytes().then((bytes) {
                  // Salvar a assinatura e retornar o caminho
                  // Este é um exemplo simplificado
                  Navigator.pop(context, 'assets/signature.png');
                });
              }
            },
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.isNotEmpty) {
                      _controller.toPngBytes().then((bytes) {
                        // Salvar a assinatura e retornar o caminho
                        Navigator.pop(context, 'assets/signature.png');
                      });
                    }
                  },
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
}