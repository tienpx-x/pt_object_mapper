import 'package:pt_object_mapper/pt_object_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

class TestEnum extends Enumerable<int> {
  final int rawValue;
  const TestEnum({@required this.rawValue});

  static const a = const TestEnum(rawValue: 0);
  static const b = const TestEnum(rawValue: 1);
}

void main() {
  setUp(() {
    Mappable.factories = {TestEnum: (v) => TestEnum(rawValue: v)};
  });

  test("fromJson", () {
    final transform = EnumTransform<TestEnum, int>();

    // null
    var value = transform.fromJson(null);
    expect(value, null);

    // a
    value = transform.fromJson(0);
    expect(value, TestEnum.a);

    // empty string
    value = transform.fromJson("");
    expect(value, null);

    // a in string
    value = transform.fromJson("0");
    expect(value, null);
  });

  test("toJson", () {
    final transform = EnumTransform<TestEnum, int>();

    // null
    expect(transform.toJson(null), isNull);

    // a
    expect(transform.toJson(TestEnum.a), TestEnum.a.rawValue);
  });
}
