
import "package:vector_math/vector_math_64.dart";

Matrix4 mergeTransformations(Matrix4 a, Matrix4 b) {
  Vector3 translationA = Vector3.zero();
  Quaternion rotationA = Quaternion.identity();
  Vector3 scaleA = Vector3(1, 1, 1);
  a.decompose(translationA, rotationA, scaleA);

  Vector3 translationB = Vector3.zero();
  Quaternion rotationB = Quaternion.identity();
  Vector3 scaleB = Vector3(1, 1, 1);
  b.decompose(translationB, rotationB, scaleB);

  Matrix4 matrix = Matrix4.identity();
  matrix.setFromTranslationRotationScale(translationA + translationB, rotationA * rotationB, Vector3(scaleA.x * scaleB.x, scaleA.y * scaleB.y, scaleA.z * scaleB.z));
  return matrix;
}
