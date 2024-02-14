import 'dart:math';

import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

import 'statistics.dart';

num dmean(num p) {
  return 1 / p;
}

num dvariance(num p) {
  return (1 - p) / pow(p, 2);
}

num skew(num p) {
  return (2 - p) / sqrt(1 - p);
}

num kurt(num p) {
  return (pow(p, 2) - 6 * p + 6) / (1 - p);
}

void main() {
  test(
      "randomGeometric(p) returns random geometrically distributed numbers with a mean of 1 / p.",
      () {
    final r = randomGeometricSource(randomLcg(0.7687729138471455));
    expect(mean([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(dmean(1), dvariance(1)));
    expect(mean([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(dmean(0.5), dvariance(0.5)));
    expect(mean([for (var i = 0, r0 = r(0.25); i < 10000; i++) r0()]),
        closeTo(dmean(0.25), dvariance(0.25)));
    expect(mean([for (var i = 0, r0 = r(0.125); i < 10000; i++) r0()]),
        closeTo(dmean(0.125), dvariance(0.125)));
  });

  test(
      "randomGeometric(p) returns random geometrically distributed numbers with a dvariance of (1 - p) / p^2.",
      () {
    final r = randomGeometricSource(randomLcg(0.7194220774328326));
    expect(variance([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(dvariance(1), dvariance(1) * 0.05));
    expect(variance([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(dvariance(0.5), dvariance(0.5) * 0.05));
    expect(variance([for (var i = 0, r0 = r(0.25); i < 10000; i++) r0()]),
        closeTo(dvariance(0.25), dvariance(0.25) * 0.05));
    expect(variance([for (var i = 0, r0 = r(0.125); i < 10000; i++) r0()]),
        closeTo(dvariance(0.125), dvariance(0.125) * 0.05));
  });

  test(
      "randomGeometric(p) returns random geometrically distributed numbers with a skewness of (2 - p) / sqrt(1 - p).",
      () {
    final r = randomGeometricSource(randomLcg(0.016030992648006448));
    expect(skewness([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(skew(0.5), 0.05 * skew(0.5)));
    expect(skewness([for (var i = 0, r0 = r(0.25); i < 10000; i++) r0()]),
        closeTo(skew(0.25), 0.05 * skew(0.25)));
    expect(skewness([for (var i = 0, r0 = r(0.125); i < 10000; i++) r0()]),
        closeTo(skew(0.125), 0.1 * skew(0.125)));
  });

  test(
      "randomGeometric(p) returns random geometrically distributed numbers with a kurtosis excess of (p^2 - 6 * p + 6) / (1 - p).",
      () {
    final r = randomGeometricSource(randomLcg(0.4039802168183795));
    expect(kurtosis([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(kurt(0.5), 0.2 * kurt(0.5)));
    expect(kurtosis([for (var i = 0, r0 = r(0.25); i < 10000; i++) r0()]),
        closeTo(kurt(0.25), 0.3 * kurt(0.25)));
    expect(kurtosis([for (var i = 0, r0 = r(0.125); i < 10000; i++) r0()]),
        closeTo(kurt(0.125), 0.3 * kurt(0.125)));
  });
}
