import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

import 'statistics.dart';

void main() {
  test("randomBates(n) returns random numbers with a mean of one-half", () {
    final r = randomBatesSource(randomLcg(0.6351090615932817));
    expect(mean([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(0.5, 0.05));
    expect(mean([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(0.5, 0.05));
    expect(mean([for (var i = 0, r0 = r(1.5); i < 10000; i++) r0()]),
        closeTo(0.5, 0.05));
    expect(mean([for (var i = 0, r0 = r(4.2); i < 10000; i++) r0()]),
        closeTo(0.5, 0.05));
  });

  test("randomBates(n) returns random numbers with a variance of 1 / (12 * n)",
      () {
    final r = randomBatesSource(randomLcg(0.1284832084868286));
    expect(variance([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(1 / 12, 0.05));
    expect(variance([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(1 / 120, 0.05));
    expect(variance([for (var i = 0, r0 = r(1.5); i < 10000; i++) r0()]),
        closeTo(1 / 18, 0.05));
    expect(variance([for (var i = 0, r0 = r(4.2); i < 10000; i++) r0()]),
        closeTo(1 / 50.4, 0.05));
  });

  test("randomBates(n) returns random numbers with a skewness of 0", () {
    final r = randomBatesSource(randomLcg(0.051567609139606674));
    expect(skewness([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
    expect(skewness([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
    expect(skewness([for (var i = 0, r0 = r(1.5); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
    expect(skewness([for (var i = 0, r0 = r(4.2); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
  });

  test("randomBates(n) returns random numbers with a kurtosis of -6 / (5 * n)",
      () {
    final r = randomBatesSource(randomLcg(0.696913354780724));
    expect(kurtosis([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(-6 / 5, 0.05));
    expect(kurtosis([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(-6 / 50, 0.1));
    expect(kurtosis([for (var i = 0, r0 = r(1.5); i < 10000; i++) r0()]),
        closeTo(-6 / 7.5, 0.05));
    expect(kurtosis([for (var i = 0, r0 = r(4.2); i < 10000; i++) r0()]),
        closeTo(-6 / 21, 0.05));
  });

  test("randomBates(0) is equivalent to randomUniform()", () {
    final r = randomBatesSource(randomLcg(0.7717596603725383));
    expect(mean([for (var i = 0, r0 = r(0); i < 10000; i++) r0()]),
        closeTo(0.5, 0.05));
    expect(variance([for (var i = 0, r0 = r(0); i < 10000; i++) r0()]),
        closeTo(1 / 12, 0.05));
    expect(skewness([for (var i = 0, r0 = r(0); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
    expect(kurtosis([for (var i = 0, r0 = r(0); i < 10000; i++) r0()]),
        closeTo(-6 / 5, 0.05));
  });
}
