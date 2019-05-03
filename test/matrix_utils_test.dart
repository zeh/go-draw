import "package:flutter_test/flutter_test.dart";
import "package:go_draw/src/utils/matrix_utils.dart";
import "package:vector_math/vector_math_64.dart";

void main() {
  group("mergeMatrixes", () {
    test("works with identity", () {
      Matrix4 a = Matrix4.identity();
      Matrix4 b = Matrix4.identity();
      Matrix4 c = Matrix4.identity();
      expect(mergeTransformations(a, b), c);
    });

    test("works when translating", () {
      Matrix4 a = Matrix4.identity();
      a.translate(10.0, 20.0);
      Matrix4 b = Matrix4.identity();
      b.translate(-5.0, 12.0);
      Matrix4 c = Matrix4.identity();
      c.translate(5.0, 32.0);
      expect(mergeTransformations(a, b), c);
    });

    test("works when scaling", () {
      Matrix4 a = Matrix4.identity();
      a.scale(2.0);
      Matrix4 b = Matrix4.identity();
      b.scale(3.0);
      Matrix4 c = Matrix4.identity();
      c.scale(6.0);
      expect(mergeTransformations(a, b), c);
    });

    test("works when rotating", () {
      Matrix4 a = Matrix4.identity();
      a.rotateZ(0.4);
      Matrix4 b = Matrix4.identity();
      b.rotateZ(-0.1);
      Matrix4 c = Matrix4.identity();
      c.rotateZ(0.3);
      Matrix4 result = mergeTransformations(a, b);
      for (var i = 0; i < 16; i++) {
        expect(result[i], moreOrLessEquals(c[i], epsilon: 1e-10));
      }
    });

    test("works when combining a scaled and a rotated matrix", () {
      Matrix4 a = Matrix4.identity();
      a.scale(2.0);
      Matrix4 b = Matrix4.identity();
      b.translate(10.0, 12.0);
      Matrix4 c = Matrix4.identity();
      c.scale(2.0);
      c.leftTranslate(10.0, 12.0);
      expect(mergeTransformations(a, b), c);
    });

    test("works when combining two fully transformed matrixes", () {
      Matrix4 a = Matrix4.identity();
      a.scale(2.0);
      a.rotateZ(0.5);
      a.leftTranslate(12.0, 16.0);
      Matrix4 b = Matrix4.identity();
      b.scale(3.0);
      b.rotateZ(0.2);
      a.leftTranslate(-5.0, 2.0);
      Matrix4 c = Matrix4.identity();
      c.scale(6.0);
      c.rotateZ(0.7);
      c.leftTranslate(7.0, 18.0);
      Matrix4 result = mergeTransformations(a, b);
      expect(result, c);
    });
  });
}
