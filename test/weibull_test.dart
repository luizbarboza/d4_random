import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

void main() {
  test("randomWeibull() returns random numbers with the specified mean", () {
    final r = randomWeibullSource(randomLcg(0.28845828610535373));
    expect(mean([for (var i = 0, r0 = r(9); i < 10000; i++) r0()]),
        closeTo(0.947, 0.1));
    expect(mean([for (var i = 0, r0 = r(3); i < 10000; i++) r0()]),
        closeTo(0.893, 0.1));
    expect(mean([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(1, 0.1));
    expect(mean([for (var i = 0, r0 = r(0.3); i < 10000; i++) r0()]),
        closeTo(9.260, 1));
    expect(mean([for (var i = 0, r0 = r(0); i < 10000; i++) r0()]),
        closeTo(0.577, 0.1));
    expect(mean([for (var i = 0, r0 = r(-3); i < 10000; i++) r0()]),
        closeTo(1.354, 0.1));
    expect(mean([for (var i = 0, r0 = r(-9); i < 10000; i++) r0()]),
        closeTo(1.078, 0.1));
    expect(mean([for (var i = 0, r0 = r(4, 1, 2); i < 10000; i++) r0()]),
        closeTo(2.813, 0.2));
    expect(mean([for (var i = 0, r0 = r(-4, 1, 2); i < 10000; i++) r0()]),
        closeTo(3.451, 0.2));
  });

  test("randomWeibull() returns random numbers with the specified deviation",
      () {
    final r = randomWeibullSource(randomLcg(0.6675582430306972));
    expect(deviation([for (var i = 0, r0 = r(9); i < 10000; i++) r0()]),
        closeTo(0.126, 0.02));
    expect(deviation([for (var i = 0, r0 = r(3); i < 10000; i++) r0()]),
        closeTo(0.324, 0.06));
    expect(deviation([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(1, 0.2));
    expect(deviation([for (var i = 0, r0 = r(0.3); i < 10000; i++) r0()]),
        greaterThan(30));
    expect(deviation([for (var i = 0, r0 = r(0); i < 10000; i++) r0()]),
        closeTo(1.282, 0.05));
    expect(deviation([for (var i = 0, r0 = r(-3); i < 10000; i++) r0()]),
        closeTo(0.919, 0.4));
    expect(deviation([for (var i = 0, r0 = r(-9); i < 10000; i++) r0()]),
        closeTo(0.169, 0.02));
    expect(deviation([for (var i = 0, r0 = r(4, 1, 2); i < 10000; i++) r0()]),
        closeTo(0.509, 0.1));
    expect(deviation([for (var i = 0, r0 = r(-4, 1, 2); i < 10000; i++) r0()]),
        closeTo(1.0408, 0.1));
  });
}
