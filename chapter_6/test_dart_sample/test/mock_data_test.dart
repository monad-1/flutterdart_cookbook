import 'package:test/test.dart';
import 'package:test_dart_sample/test_dart_sample.dart';

Future<double> _loadResource(int testDelay) async {
  try {
    await Future.delayed(Duration(seconds: testDelay));
    return 10.0;
  } catch (e) {
    print(e);
    return 0.0;
  }
}

void main() {
  test('Travel Distance Delay', () async {
    // Arrange
    int customDelay = 5;
    var distance = await _loadResource(customDelay);
    var expectedDistance = distance;
    // Act
    var travel = Travel(expectedDistance);
    var result = travel.distance;
    // Assert
    expect(expectedDistance, result);
  });
}
