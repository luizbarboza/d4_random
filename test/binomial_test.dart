import 'dart:math';

import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

import 'statistics.dart';

num dmean(num n, num p) {
  return n * p;
}

num dvariance(num n, num p) {
  return n * p * (1 - p);
}

num skew(num n, num p) {
  return (1 - 2 * p) / sqrt(dvariance(n, p));
}

num kurt(num n, num p) {
  return (6 * pow(p, 2) - 6 * p + 1) / (dvariance(n, p));
}

void main() {
  test(
      "randomBinomial(n, p) returns random binomial distributed numbers with a mean of n * p",
      () {
    final r = randomBinomialSource(randomLcg(0.3994478770613372));
    expect(mean([for (var i = 0, r0 = r(100, 1); i < 10000; i++) r0()]),
        closeTo(dmean(100, 1), dvariance(100, 1)));
    expect(mean([for (var i = 0, r0 = r(100, 0.5); i < 10000; i++) r0()]),
        closeTo(dmean(100, 0.5), dvariance(100, 0.5)));
    expect(mean([for (var i = 0, r0 = r(100, 0.25); i < 10000; i++) r0()]),
        closeTo(dmean(100, 0.25), dvariance(100, 0.25)));
    expect(mean([for (var i = 0, r0 = r(100, 0); i < 10000; i++) r0()]),
        closeTo(dmean(100, 0), dvariance(100, 0)));
    expect(mean([for (var i = 0, r0 = r(0, 0); i < 10000; i++) r0()]),
        closeTo(dmean(0, 0), dvariance(0, 0)));
  });

  test(
      "randomBinomial(n, p) returns random binomial distributed numbers with a variance of n * p * (1 - p)",
      () {
    final r = randomBinomialSource(randomLcg(0.7214876234380256));
    expect(variance([for (var i = 0, r0 = r(100, 1); i < 10000; i++) r0()]),
        closeTo(dvariance(100, 1), 0));
    expect(variance([for (var i = 0, r0 = r(100, 0.5); i < 10000; i++) r0()]),
        closeTo(dvariance(100, 0.5), 0.5));
    expect(variance([for (var i = 0, r0 = r(100, 0.25); i < 10000; i++) r0()]),
        closeTo(dvariance(100, 0.25), 1));
    expect(variance([for (var i = 0, r0 = r(100, 0); i < 10000; i++) r0()]),
        closeTo(dvariance(100, 0), 0));
    expect(variance([for (var i = 0, r0 = r(0, 0); i < 10000; i++) r0()]),
        closeTo(dvariance(0, 0), 0));
  });

  test(
      "randomBinomial(n, p) returns random binomial distributed numbers with a skewness of (1 - 2 * p) / sqrt(n * p * (1 - p))",
      () {
    final r = randomBinomialSource(randomLcg(0.0646181509291679));
    expect(skewness([for (var i = 0, r0 = r(100, 0.05); i < 10000; i++) r0()]),
        closeTo(skew(100, 0.05), 0.05));
    expect(skewness([for (var i = 0, r0 = r(100, 0.10); i < 10000; i++) r0()]),
        closeTo(skew(100, 0.10), 0.05));
    expect(skewness([for (var i = 0, r0 = r(100, 0.15); i < 10000; i++) r0()]),
        closeTo(skew(100, 0.15), 0.05));
    expect(skewness([for (var i = 0, r0 = r(100, 0.20); i < 10000; i++) r0()]),
        closeTo(skew(100, 0.20), 0.05));
    expect(skewness([for (var i = 0, r0 = r(100, 0.25); i < 10000; i++) r0()]),
        closeTo(skew(100, 0.25), 0.05));
    expect(skewness([for (var i = 0, r0 = r(100, 0.30); i < 10000; i++) r0()]),
        closeTo(skew(100, 0.30), 0.05));
    expect(skewness([for (var i = 0, r0 = r(100, 0.35); i < 10000; i++) r0()]),
        closeTo(skew(100, 0.35), 0.05));
    expect(skewness([for (var i = 0, r0 = r(100, 0.40); i < 10000; i++) r0()]),
        closeTo(skew(100, 0.40), 0.05));
    expect(skewness([for (var i = 0, r0 = r(100, 0.45); i < 10000; i++) r0()]),
        closeTo(skew(100, 0.45), 0.05));
  });

  test(
      "randomBinomial(n, p) returns random binomial distributed numbers with a kurtosis excess of (6 * p^2 - 6 * p - 1) / (n * p * (1 - p))",
      () {
    final r = randomBinomialSource(randomLcg(0.6451552018202751));
    expect(kurtosis([for (var i = 0, r0 = r(100, 0.05); i < 10000; i++) r0()]),
        closeTo(kurt(100, 0.05), 0.2));
    expect(kurtosis([for (var i = 0, r0 = r(100, 0.10); i < 10000; i++) r0()]),
        closeTo(kurt(100, 0.10), 0.1));
    expect(kurtosis([for (var i = 0, r0 = r(100, 0.15); i < 10000; i++) r0()]),
        closeTo(kurt(100, 0.15), 0.1));
    expect(kurtosis([for (var i = 0, r0 = r(100, 0.20); i < 10000; i++) r0()]),
        closeTo(kurt(100, 0.20), 0.1));
    expect(kurtosis([for (var i = 0, r0 = r(100, 0.25); i < 10000; i++) r0()]),
        closeTo(kurt(100, 0.25), 0.1));
    expect(kurtosis([for (var i = 0, r0 = r(100, 0.30); i < 10000; i++) r0()]),
        closeTo(kurt(100, 0.30), 0.1));
    expect(kurtosis([for (var i = 0, r0 = r(100, 0.35); i < 10000; i++) r0()]),
        closeTo(kurt(100, 0.35), 0.1));
    expect(kurtosis([for (var i = 0, r0 = r(100, 0.40); i < 10000; i++) r0()]),
        closeTo(kurt(100, 0.40), 0.1));
    expect(kurtosis([for (var i = 0, r0 = r(100, 0.45); i < 10000; i++) r0()]),
        closeTo(kurt(100, 0.45), 0.05));
  });
}
