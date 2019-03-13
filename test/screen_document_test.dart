import "package:test/test.dart";
import "package:go_draw/src/widgets/screen/screen_document.dart";

void main() {
  group("ScreenDocument", () {
    test("should start empty", () {
      final doc = new ScreenDocument();
      expect(doc.width, 0);
      expect(doc.height, 0);
    });

    test("should resize", () {
      final doc = new ScreenDocument();
      doc.resize(4, 4);
      expect(doc.width, 4);
      expect(doc.height, 4);
      doc.resize(1, 1);
      expect(doc.width, 1);
      expect(doc.height, 1);
    });

    test("should auto-resize", () {
      final doc = new ScreenDocument();
      doc.setChar(2, 2, 32);
      expect(doc.width, 3);
      expect(doc.height, 3);
    });
  });
}
