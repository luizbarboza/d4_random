import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

import 'statistics.dart';

void main() {
  test("randomIrwinHall(n) returns random numbers with a mean of n / 2", () {
    final r = randomIrwinHallSource(randomLcg(0.028699383123896194));
    expect(mean([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(1 / 2, 0.05));
    expect(mean([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(10 / 2, 0.05));
    expect(mean([for (var i = 0, r0 = r(1.5); i < 10000; i++) r0()]),
        closeTo(1.5 / 2, 0.05));
    expect(mean([for (var i = 0, r0 = r(4.2); i < 10000; i++) r0()]),
        closeTo(4.2 / 2, 0.05));
  });

  test("randomIrwinHall(n) returns random numbers with a variance of n / 12",
      () {
    final r = randomIrwinHallSource(randomLcg(0.1515471143624345));
    expect(variance([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(1 / 12, 0.05));
    expect(variance([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(10 / 12, 0.05));
    expect(variance([for (var i = 0, r0 = r(1.5); i < 10000; i++) r0()]),
        closeTo(1.5 / 12, 0.05));
    expect(variance([for (var i = 0, r0 = r(4.2); i < 10000; i++) r0()]),
        closeTo(4.2 / 12, 0.05));
  });

  test("randomIrwinHall(n) returns random numbers with a skewness of 0", () {
    final r = randomIrwinHallSource(randomLcg(0.47334122849782845));
    expect(skewness([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
    expect(skewness([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
    expect(skewness([for (var i = 0, r0 = r(1.5); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
    expect(skewness([for (var i = 0, r0 = r(4.2); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
  });

  test(
      "randomIrwinHall(n) returns random numbers with a kurtosis of -6 / (5 * n)",
      () {
    final r = randomIrwinHallSource(randomLcg(0.8217913599574529));
    expect(kurtosis([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(-6 / 5, 0.1));
    expect(kurtosis([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(-6 / 50, 0.1));
    expect(kurtosis([for (var i = 0, r0 = r(1.5); i < 10000; i++) r0()]),
        closeTo(-6 / 7.5, 0.05));
    expect(kurtosis([for (var i = 0, r0 = r(4.2); i < 10000; i++) r0()]),
        closeTo(-6 / 21, 0.05));
  });
}
