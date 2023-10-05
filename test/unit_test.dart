import 'package:flutter_test/flutter_test.dart';
import 'package:nst_test/convert/converter.dart';

void main() {
  test('test converter return 188.7312 when adding 62.9104 and 3', () {
    final converter = Converter();

    final result = converter.convert('3', 62.9104);

    expect(result, 188.7312);
  });

  test('test converter return 0 when adding 62.9104 and 0', () {
    final converter = Converter();

    final result = converter.convert('0', 62.9104);

    expect(result, 0);
  });

  test('test converter return ArgumentError when adding 62.9104 and -10', () {
    final converter = Converter();

    expect(() => converter.convert('-10.0', 62.9104),
        throwsA(predicate((e) => e is ArgumentError)));
  });

  test(
      'test converter return ArgumentError when adding too large value and 62.9104', () {
    final converter = Converter();

    expect(() => converter.convert('1000000000000000000000000000000', 62.9104),
        throwsA(predicate((e) => e is ArgumentError)));
  });
}