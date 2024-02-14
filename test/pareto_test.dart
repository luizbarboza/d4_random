import 'dart:math';

import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

num ddeviation(num n) {
  return sqrt(n / ((n - 1) * (n - 1) * (n - 2)));
}

void main() {
  test("randomPareto() returns randoms with specified mean", () {
    final r = randomParetoSource(randomLcg(0.6165632948194271));
    expect(mean([for (var i = 0, r0 = r(0.0); i < 10000; i++) r0()]),
        double.infinity);
    expect(mean([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        greaterThan(8));
    expect(mean([for (var i = 0, r0 = r(3); i < 10000; i++) r0()]),
        closeTo(1.5, 0.4));
    expect(mean([for (var i = 0, r0 = r(5); i < 10000; i++) r0()]),
        closeTo(1.25, 0.1));
    expect(mean([for (var i = 0, r0 = r(11); i < 10000; i++) r0()]),
        closeTo(1.1, 0.1));
  });

  test("randomPareto() returns randoms with specified deviation", () {
    final r = randomParetoSource(randomLcg(0.5733127851951378));
    expect(
        deviation([for (var i = 0, r0 = r(0.0); i < 10000; i++) r0()]), isNaN);
    expect(deviation([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        greaterThan(70));
    expect(deviation([for (var i = 0, r0 = r(3); i < 10000; i++) r0()]),
        closeTo(ddeviation(3), 0.5));
    expect(deviation([for (var i = 0, r0 = r(5); i < 10000; i++) r0()]),
        closeTo(ddeviation(5), 0.05));
    expect(deviation([for (var i = 0, r0 = r(11); i < 10000; i++) r0()]),
        closeTo(ddeviation(11), 0.05));
  });

  test("randomPareto(3) returns randoms with mean of 1.5 and deviation of 0.9",
      () {
    final r = randomParetoSource(randomLcg(0.9341538627900958));
    expect(deviation([for (var i = 0, r0 = r(3); i < 10000; i++) r0()]),
        closeTo(0.9, 0.2));
    expect(mean([for (var i = 0, r0 = r(3); i < 10000; i++) r0()]),
        closeTo(1.5, 0.05));
  });
}
