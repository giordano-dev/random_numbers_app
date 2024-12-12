import 'dart:math';
import 'exam_api.dart';

class ExamApiImpl implements ExamApi {
  @override
  List<int> getRandomNumbers(int quantity) {
    final random = Random();
    final numbers = <int>{};

    //Garante números únicos
    while (numbers.length < quantity) {
      numbers.add(random.nextInt(100)); //Gera um número inteiro
    }

    return numbers.toList();
  }

  @override
  bool checkOrder(List<int> numbers) {
    for (int i = 0; i < numbers.length - 1; i++) {
      if (numbers[i] > numbers[i + 1]) {
        return false;
      }
    }
    return true;
  }
}
