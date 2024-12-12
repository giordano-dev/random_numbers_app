import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necessário para TextInputFormatter
import '../api/exam_api_impl.dart';
import '../models/number_model.dart';

class RandomNumbersScreen extends StatefulWidget {
  const RandomNumbersScreen({super.key});

  @override
  _RandomNumbersScreenState createState() => _RandomNumbersScreenState();
}

class _RandomNumbersScreenState extends State<RandomNumbersScreen> {
  final ExamApiImpl _api = ExamApiImpl();
  List<NumberModel> _numbers = [];
  bool? _isOrdered;
  int? _quantity;

  void _generateNumbers() {
    if (_quantity == null || _quantity! <= 0) {
      _showErrorDialog("Por favor, insira um número válido entre 1 e 99.");
      return;
    }
    setState(() {
      final randomNumbers = _api.getRandomNumbers(_quantity!);
      _numbers = NumberModel.fromList(randomNumbers);
      _isOrdered = null;
    });
  }

  void _checkOrder() {
    setState(() {
      _isOrdered = _api.checkOrder(NumberModel.toList(_numbers));
    });
  }

  void _reset() {
    setState(() {
      _numbers = [];
      _quantity = null;
      _isOrdered = null;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Erro"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordene os Números'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _numbers.isEmpty ? _buildInitialState() : _buildListState(),
      ),
    );
  }

  Widget _buildInitialState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Digite a quantidade de números (máx. 99) que deseja gerar:",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Quantidade de números',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Apenas números
            LengthLimitingTextInputFormatter(2), // Máximo de 2 dígitos
          ],
          onChanged: (value) {
            setState(() {
              _quantity = int.tryParse(value);
            });
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _generateNumbers,
          child: const Text("Gerar Números"),
        ),
      ],
    );
  }

  Widget _buildListState() {
    return Column(
      children: [
        const Text(
          "Arraste para reordenar: o menor número deve ficar no topo e o maior embaixo.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final item = _numbers.removeAt(oldIndex);
                _numbers.insert(newIndex, item);
              });
            },
            children: [
              for (int i = 0; i < _numbers.length; i++)
                ListTile(
                  key: ValueKey(_numbers[i].value),
                  title: Text(
                    _numbers[i].value.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: i < _numbers.length - 1 &&
                              _numbers[i].value > _numbers[i + 1].value
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                  trailing: const Icon(Icons.drag_handle),
                ),
            ],
          ),
        ),
        if (_isOrdered != null)
          Text(
            _isOrdered!
                ? 'A lista está em ordem!'
                : 'A lista não está em ordem!',
            style: TextStyle(
              color: _isOrdered! ? Colors.green : Colors.red,
              fontSize: 18,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _checkOrder,
              child: const Text("Verificar Ordem"),
            ),
            ElevatedButton(
              onPressed: _reset,
              child: const Text("Reiniciar"),
            ),
          ],
        ),
      ],
    );
  }
}
