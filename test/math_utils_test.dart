import "package:flutter_test/flutter_test.dart";
import "package:go_draw/src/utils/math_utils.dart";

void main() {
  group("math_utils", () {
    group("clamp", () {
      test("should clamp a value", () {
        expect(clamp(0, 0, 1), 0);
        expect(clamp(-1, 0, 1), 0);
        expect(clamp(0.5, 0, 1), 0.5);
        expect(clamp(1, 0, 1), 1);
        expect(clamp(2, 0, 1), 1);
        expect(clamp(20, 0, 10), 10);
        expect(clamp(3, 4, 10), 4);
      });
    });

    group("map", () {
      test("should map a value between ranges", () {
        // Normal mappings
        expect(map(0, 0, 10, 50, 100), 50);
        expect(map(5, 0, 10, 50, 100), 75);
        expect(map(10, 0, 10, 50, 100), 100);

        // Extrapolated mappings
        expect(map(20, 0, 10, 50, 100), 150);
        expect(map(-10, 0, 10, 50, 100), 0);

        // Clamped mappings
        expect(map(-10, 0, 10, 50, 100, true), 50);
        expect(map(20, 0, 10, 50, 100, true), 100);

        // Mapping with reverse ranges
        expect(map(0, 0, 10, 100, 50), 100);
        expect(map(0, 10, 0, 100, 50), 50);
        expect(map(0, 10, 0, 50, 100), 100);
      });
    });
  });
}
