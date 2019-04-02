import "package:go_draw/src/data/screen/document/screen_document.dart";
import "package:test/test.dart";

void main() {
  group("ScreenDocument", () {
    test("should start empty", () {
      final doc = new ScreenDocument();
      expect(doc.width, 0);
      expect(doc.height, 0);
    });

    test("resize() works", () {
      final doc = new ScreenDocument();
      doc.resize(4, 4);
      expect(doc.width, 4);
      expect(doc.height, 4);
      doc.resize(1, 1);
      expect(doc.width, 1);
      expect(doc.height, 1);
    });

    test("setChar() works", () {
      final doc = new ScreenDocument();
      doc.setChar(2, 2, 32);
      expect(doc.getChar(2, 2), 32);
    });

    test("setChar() auto-resizes", () {
      final doc = new ScreenDocument();
      expect(doc.width, 0);
      expect(doc.height, 0);
      doc.setChar(2, 2, 32);
      expect(doc.width, 3);
      expect(doc.height, 3);
    });

    test("setColor() works", () {
      final doc = new ScreenDocument();
      doc.setColor(1, 1, 8, 1);
      expect(doc.getForegroundColor(1, 1), 8);
      expect(doc.getBackgroundColor(1, 1), 1);
    });

    test("setColor() auto-resizes", () {
      final doc = new ScreenDocument();
      expect(doc.width, 0);
      expect(doc.height, 0);
      doc.setColor(3, 2, 2, 1);
      expect(doc.width, 4);
      expect(doc.height, 3);
    });

    test("resize() works", () {
      final doc = new ScreenDocument();
      expect(doc.width, 0);
      expect(doc.height, 0);
      doc.resize(2, 2);
      expect(doc.width, 2);
      expect(doc.height, 2);
      doc.resize(10, 4);
      expect(doc.width, 10);
      expect(doc.height, 4);
      doc.resize(10, 4);
      expect(doc.width, 10);
      expect(doc.height, 4);
      doc.resize(1, 1);
      expect(doc.width, 1);
      expect(doc.height, 1);
    });

    test("resize() maintains existing chars and colors", () {
      final doc = new ScreenDocument();
      doc.resize(20, 20);
      expect(doc.width, 20);
      expect(doc.height, 20);
      doc.setChar(10, 10, 32);
      doc.setColor(10, 10, 9, 2);
      expect(doc.getChar(10, 10), 32);
      expect(doc.getForegroundColor(10, 10), 9);
      expect(doc.getBackgroundColor(10, 10), 2);
      doc.resize(40, 40);
      expect(doc.width, 40);
      expect(doc.height, 40);
      expect(doc.getChar(10, 10), 32);
      expect(doc.getForegroundColor(10, 10), 9);
      expect(doc.getBackgroundColor(10, 10), 2);
      doc.resize(11, 11);
      expect(doc.width, 11);
      expect(doc.height, 11);
      expect(doc.getChar(10, 10), 32);
      expect(doc.getForegroundColor(10, 10), 9);
      expect(doc.getBackgroundColor(10, 10), 2);
    });
  });
}
