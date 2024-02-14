import 'dart:math';

import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

import 'statistics.dart';

num dmean(num p) {
  return p;
}

num dvariance(num p) {
  return p * (1 - p);
}

num skew(num p) {
  return (1 - 2 * p) / sqrt(dvariance(p));
}

num kurt(num p) {
  return (6 * pow(p, 2) - 6 * p + 1) / (dvariance(p));
}

void main() {
  test(
      "randomBernoulli(p) returns random bernoulli distributed numbers with a mean of p",
      () {
    final r = randomBernoulliSource(randomLcg(0.48444190806583465));
    expect(mean([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(dmean(1), dvariance(1)));
    expect(mean([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(dmean(0.5), dvariance(0.5)));
    expect(mean([for (var i = 0, r0 = r(0.25); i < 10000; i++) r0()]),
        closeTo(dmean(0.25), dvariance(0.25)));
    expect(mean([for (var i = 0, r0 = r(0); i < 10000; i++) r0()]),
        closeTo(dmean(0), dvariance(0)));
  });

  test(
      "randomBernoulli(p) returns random bernoulli distributed numbers with a variance of p * (1 - p)",
      () {
    final r = randomBernoulliSource(randomLcg(0.9781605192898934));
    expect(variance([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(dvariance(1), 0));
    expect(variance([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(dvariance(0.5), 0.05));
    expect(variance([for (var i = 0, r0 = r(0.25); i < 10000; i++) r0()]),
        closeTo(dvariance(0.25), 0.05));
    expect(variance([for (var i = 0, r0 = r(0); i < 10000; i++) r0()]),
        closeTo(dvariance(0), 0));
  });

  test(
      "randomBernoulli(p) returns random bernoulli distributed numbers with a skewness of (1 - 2 * p) / sqrt(p * (1 - p)).",
      () {
    final r = randomBernoulliSource(randomLcg(0.9776249148208429));
    expect(skewness([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(skew(0.5), 0.08));
    expect(skewness([for (var i = 0, r0 = r(0.25); i < 10000; i++) r0()]),
        closeTo(skew(0.25), 0.05));
  });

  test(
      "randomBernoulli(p) returns random bernoulli distributed numbers with a kurtosis excess of (6 * p^2 - 6 * p - 1) / (p * (1 - p)).",
      () {
    final r = randomBernoulliSource(randomLcg(0.8260973119979638));
    expect(kurtosis([for (var i = 0, r0 = r(0.05); i < 10000; i++) r0()]),
        closeTo(kurt(0.05), kurt(0.05) * 0.2));
    expect(kurtosis([for (var i = 0, r0 = r(0.10); i < 10000; i++) r0()]),
        closeTo(kurt(0.10), kurt(0.10) * 0.2));
    expect(kurtosis([for (var i = 0, r0 = r(0.15); i < 10000; i++) r0()]),
        closeTo(kurt(0.15), kurt(0.15) * 0.2));
    expect(kurtosis([for (var i = 0, r0 = r(0.20); i < 10000; i++) r0()]),
        closeTo(kurt(0.20), kurt(0.20) * 0.4));
  });
}
