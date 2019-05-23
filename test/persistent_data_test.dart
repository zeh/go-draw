import "package:go_draw/src/utils/persistent_data.dart";
import "package:test/test.dart";

void main() {

  group("PersistentData", () {
    setUpAll(() {
      PersistentData.resetForTests();
    });

    test("can wait for initialization", () {
      PersistentData p = PersistentData.get("a");
      p.read().whenComplete(() {
        expect(p.isInitialized(), true);
      });
    });

    test("can create instance", () {
      PersistentData p = PersistentData.get("a");
      expect(p, isNotNull);
    });

    test("can read invalid string", () {
      PersistentData p = PersistentData.get("a");
      expect(p.getString("str", "default value"), "default value");
    });

    test("can set and read string", () {
      PersistentData p = PersistentData.get("a");
      p.setString("str", "a value");
      expect(p.getString("str"), "a value");
    });
  });
}
