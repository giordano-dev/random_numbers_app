import 'package:flutter/material.dart';
import 'package:random_numbers_app/models/number_model.dart';

class NumberListWidget extends StatelessWidget {
  final List<NumberModel> numbers;
  final void Function(int oldIndex, int newIndex) onReorder;

  const NumberListWidget({
    super.key,
    required this.numbers,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: onReorder,
      children: [
        for (final model in numbers)
          ListTile(
            key: ValueKey(model.value),
            title: Text(model.value.toString()),
          ),
      ],
    );
  }
}
