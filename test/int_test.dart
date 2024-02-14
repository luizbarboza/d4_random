import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

void main() {
  test("randomInt(max) returns random integers with a mean of (max - 1) / 2",
      () {
    final r = randomIntSource(randomLcg(0.7350864698209636));
    expect(mean([for (var i = 0, r0 = r(max: 3); i < 10000; i++) r0()]),
        closeTo(1.0, 0.05));
    expect(mean([for (var i = 0, r0 = r(max: 21); i < 10000; i++) r0()]),
        closeTo(10.0, 0.5));
  });

  test("randomInt(max) returns random integers in the range [0, max - 1]", () {
    final r = randomIntSource(randomLcg(0.17809137433591848));
    expect(
        extent([for (var i = 0, r0 = r(max: 3); i < 10000; i++) r0()]), (0, 2));
    expect(extent([for (var i = 0, r0 = r(max: 21); i < 10000; i++) r0()]),
        (0, 20));
  });

  test(
      "randomInt(min, max) returns random integers with a mean of (min + max - 1) / 2",
      () {
    final r = randomIntSource(randomLcg(0.46394764422984647));
    expect(
        mean([for (var i = 0, r0 = r(min: 10, max: 43); i < 10000; i++) r0()]),
        closeTo(26, 0.5));
  });

  test(
      "randomInt(min, max) returns random integers in the range [min, max - 1]",
      () {
    final r = randomIntSource(randomLcg(0.9598431138570096));
    expect(
        extent(
            [for (var i = 0, r0 = r(min: 10, max: 42); i < 10000; i++) r0()]),
        (10, 41));
  });
}
