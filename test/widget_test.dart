// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:random_numbers_app/api/exam_api_impl.dart';

void main() {
  final api = ExamApiImpl();

  test('getRandomNumbers returns unique values', () {
    final numbers = api.getRandomNumbers(10);
    expect(numbers.length, equals(10));
    expect(numbers.toSet().length, equals(10));
  });

  test('checkOrder identifies ordered list', () {
    final isOrdered = api.checkOrder([1, 2, 3, 4, 5]);
    expect(isOrdered, isTrue);
  });

  test('checkOrder identifies unordered list', () {
    final isOrdered = api.checkOrder([5, 1, 3, 2, 4]);
    expect(isOrdered, isFalse);
  });
}
