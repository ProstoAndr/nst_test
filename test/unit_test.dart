import 'package:flutter_test/flutter_test.dart';
import 'package:nst_test/convert/converter.dart';

void main() {
  test(
    'test converter return 188.7312 when adding 62.9104 and 3', (){
      final converter = Converter();

      final result = converter.convert('62.9104', 3);

      expect(result, 188.7312);
      }
  );
}