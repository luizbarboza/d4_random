import 'dart:math';

import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

import 'statistics.dart';

void main() {
  test("randomGamma(k) returns random numbers with a mean of k", () {
    final r = randomGammaSource(randomLcg(0.8177609532536807));
    expect(mean([for (var i = 0, r0 = r(0.1); i < 10000; i++) r0()]),
        closeTo(0.1, 0.01));
    expect(mean([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(0.5, 0.05));
    expect(mean([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(1, 0.05));
    expect(mean([for (var i = 0, r0 = r(2); i < 10000; i++) r0()]),
        closeTo(2, 0.05));
    expect(mean([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(10, 0.05));
  });

  test("randomGamma(k) returns random numbers with a variance of k", () {
    final r = randomGammaSource(randomLcg(0.6494198931625885));
    expect(variance([for (var i = 0, r0 = r(0.1); i < 10000; i++) r0()]),
        closeTo(0.1, 0.005));
    expect(variance([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(0.5, 0.05));
    expect(variance([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(1, 0.05));
    expect(variance([for (var i = 0, r0 = r(2); i < 10000; i++) r0()]),
        closeTo(2, 0.1));
    expect(variance([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(10, 0.5));
  });

  test("randomGamma(k) returns random numbers with a skewness of 2 / sqrt(k)",
      () {
    final r = randomGammaSource(randomLcg(0.02223371708142996));
    expect(skewness([for (var i = 0, r0 = r(0.1); i < 10000; i++) r0()]),
        closeTo(sqrt(40), 1));
    expect(skewness([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(sqrt(8), 0.25));
    expect(skewness([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(2, 0.1));
    expect(skewness([for (var i = 0, r0 = r(2); i < 10000; i++) r0()]),
        closeTo(sqrt(2), 0.1));
    expect(skewness([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(sqrt(0.4), 0.05));
  });

  test("randomGamma(k) returns random numbers with an excess kurtosis of 6 / k",
      () {
    final r = randomGammaSource(randomLcg(0.19568718910927974));
    expect(kurtosis([for (var i = 0, r0 = r(0.1); i < 10000; i++) r0()]),
        closeTo(60, 15));
    expect(kurtosis([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(12, 3));
    expect(kurtosis([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(6, 1.5));
    expect(kurtosis([for (var i = 0, r0 = r(2); i < 10000; i++) r0()]),
        closeTo(3, 1));
    expect(kurtosis([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(0.6, 0.2));
  });

  test(
      "randomGamma(k, theta) returns random numbers with a mean of k * theta and a variance of k * theta^2",
      () {
    final r = randomGammaSource(randomLcg(0.9608725416165995));
    expect(mean([for (var i = 0, r0 = r(1, 2); i < 10000; i++) r0()]),
        closeTo(2, 0.05));
    expect(mean([for (var i = 0, r0 = r(2, 4); i < 10000; i++) r0()]),
        closeTo(8, 0.2));
    expect(deviation([for (var i = 0, r0 = r(1, 2); i < 10000; i++) r0()]),
        closeTo(2, 0.1));
    expect(deviation([for (var i = 0, r0 = r(2, 4); i < 10000; i++) r0()]),
        closeTo(sqrt(2) * 4, 0.1));
  });
}
