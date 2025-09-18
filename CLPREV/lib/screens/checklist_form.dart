import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import '../models/checklist_model.dart';
import '../services/pdf_service.dart';
import 'signature_screen.dart';

class ChecklistFormScreen extends StatefulWidget {
  @override
  _ChecklistFormScreenState createState() => _ChecklistFormScreenState();
}

class _ChecklistFormScreenState extends State<ChecklistFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ChecklistModel _checklist = ChecklistModel();
  final List<String> _frequencyOptions = ['Eventual', 'Intermitente', 'Permanente'];
  final List<String> _severityOptions = ['Insignificante', 'Leve', 'Moderado', 'Sério', 'Severo'];
  final List<String> _probabilityOptions = ['Quase Impossível', 'Improvável', 'Existe Possibilidade', 'Provável', 'Quase Certo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist de Avaliação Ambiental'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _generatePDF,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildCompanySection(),
              SizedBox(height: 20),
              _buildEnvironmentSection(),
              SizedBox(height: 20),
              _buildAssessmentSection(),
              SizedBox(height: 20),
              _buildRisksSection(),
              SizedBox(height: 20),
              _buildSpecialWorkSection(),
              SizedBox(height: 20),
              _buildSignaturesSection(),
              SizedBox(height: 30),
              _buildGenerateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dados da Empresa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nome da Empresa *',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.companyName = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Data da Visita *',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: _checklist.visitDate.toString().substring(0, 10),
                    onSaved: (value) => _checklist.visitDate = DateTime.parse(value!),
                    validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Posto *',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _checklist.position = value!,
                    validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Avaliador *',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.evaluator = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Acompanhante',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.companion = value ?? '',
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'RGF ou Matrícula *',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.rgf = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvironmentSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descrição do Ambiente de Trabalho',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Local *',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.local = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Estrutura *',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.structure = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Área Aproximada (m²) *',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _checklist.area = value!,
                    validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Pé Direito Aproximado (m) *',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _checklist.ceilingHeight = value!,
                    validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Piso *',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.floor = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Cobertura *',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.coverage = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Ventilação *',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.ventilation = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Janela *',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.windows = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Iluminação *',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.lighting = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Avaliação Ambiental - Reconhecimento dos Agentes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Departamento/Setor *',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.department = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Funções Expostas *',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onSaved: (value) => _checklist.exposedFunctions = value!,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nº de Funcionários Expostos *',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSaved: (value) => _checklist.exposedEmployees = int.parse(value!),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRisksSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riscos Identificados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _checklist.risks.length,
              itemBuilder: (context, index) {
                return _buildRiskRow(index);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _checklist.risks.add(Risk());
                });
              },
              child: Text('Adicionar Risco'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskRow(int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tipo de Risco',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.risks[index].type = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Agente',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.risks[index].agent = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Concentração',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.risks[index].concentration = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Fonte Geradora',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.risks[index].source = value!,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Frequência',
                border: OutlineInputBorder(),
              ),
              items: _frequencyOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _checklist.risks[index].frequency = '';
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Severidade',
                border: OutlineInputBorder(),
              ),
              items: _severityOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _checklist.risks[index].severity = '';
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Probabilidade',
                border: OutlineInputBorder(),
              ),
              items: _probabilityOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _checklist.risks[index].probability = '';
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'EPI (CA)',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _checklist.risks[index].epi = value!,
            ),
            SizedBox(height: 16),
            if (_checklist.risks.length > 1)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _checklist.risks.removeAt(index);
                  });
                },
                child: Text('Remover Risco'),
                style: ElevatedButton.styleFrom(backgroundColor:  Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialWorkSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trabalhos Especiais',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Há funcionários que realizam trabalho em altura?'),
                SizedBox(width: 16),
                Switch(
                  value: _checklist.heightWork,
                  onChanged: (value) {
                    setState(() {
                      _checklist.heightWork = value;
                    });
                  },
                ),
                Text(_checklist.heightWork ? 'Sim' : 'Não'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Há funcionários que realizam trabalho em espaço confinado?'),
                SizedBox(width: 16),
                Switch(
                  value: _checklist.confinedSpace,
                  onChanged: (value) {
                    setState(() {
                      _checklist.confinedSpace = value;
                    });
                  },
                ),
                Text(_checklist.confinedSpace ? 'Sim' : 'Não'),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Observações',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              onSaved: (value) => _checklist.observations = value ?? '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignaturesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assinaturas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Assinatura do Técnico'),
                      SizedBox(height: 8),
                      _checklist.technicianSignaturePath.isEmpty
                          ? ElevatedButton(
                        onPressed: () => _captureSignature(true),
                        child: Text('Assinar'),
                      )
                          : Image.asset(
                        _checklist.technicianSignaturePath,
                        height: 100,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      Text('Assinatura do Acompanhante'),
                      SizedBox(height: 8),
                      _checklist.companionSignaturePath.isEmpty
                          ? ElevatedButton(
                        onPressed: () => _captureSignature(false),
                        child: Text('Assinar'),
                      )
                          : Image.asset(
                        _checklist.companionSignaturePath,
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerateButton() {
    return ElevatedButton(
      onPressed: _generatePDF,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'GERAR PDF',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  void _captureSignature(bool isTechnician) async {
    final signaturePath = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignatureScreen(
          title: isTechnician ? 'Assinatura do Técnico' : 'Assinatura do Acompanhante',
        ),
      ),
    );

    if (signaturePath != null) {
      setState(() {
        if (isTechnician) {
          _checklist.technicianSignaturePath = signaturePath;
        } else {
          _checklist.companionSignaturePath = signaturePath;
        }
      });
    }
  }

  void _generatePDF() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Gerar PDF
      final pdfService = PDFService();
      final pdfFile = await pdfService.generatePDF(_checklist);

      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF gerado com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Aqui você pode compartilhar ou salvar o PDF
      // Por exemplo: Share.shareFiles([pdfFile.path]);
    }
  }
}