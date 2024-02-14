import 'dart:math';

import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

num dmean(num alpha, num beta) {
  return alpha / (alpha + beta);
}

num dvariance(num alpha, num beta) {
  return (alpha * beta) / pow(alpha + beta, 2) / (alpha + beta + 1);
}

void main() {
  test(
      "randomBeta(alpha, beta) returns random numbers with a mean of alpha / (alpha + beta)",
      () {
    final r = randomBetaSource(randomLcg(0.8275880644751501));
    expect(mean([for (var i = 0, r0 = r(1, 1); i < 10000; i++) r0()]),
        closeTo(dmean(1, 1), 0.05));
    expect(mean([for (var i = 0, r0 = r(1, 2); i < 10000; i++) r0()]),
        closeTo(dmean(1, 2), 0.05));
    expect(mean([for (var i = 0, r0 = r(2, 1); i < 10000; i++) r0()]),
        closeTo(dmean(2, 1), 0.05));
    expect(mean([for (var i = 0, r0 = r(3, 4); i < 10000; i++) r0()]),
        closeTo(dmean(3, 4), 0.05));
    expect(mean([for (var i = 0, r0 = r(0.5, 0.5); i < 10000; i++) r0()]),
        closeTo(dmean(0.5, 0.5), 0.05));
    expect(mean([for (var i = 0, r0 = r(2.7, 0.3); i < 10000; i++) r0()]),
        closeTo(dmean(2.7, 0.3), 0.05));
  });

  test(
      "randomBeta(alpha, beta) returns random numbers with a variance of (alpha * beta) / (alpha + beta)^2 / (alpha + beta + 1)",
      () {
    final r = randomBetaSource(randomLcg(0.8272345925494458));
    expect(variance([for (var i = 0, r0 = r(1, 1); i < 10000; i++) r0()]),
        closeTo(dvariance(1, 1), 0.05));
    expect(variance([for (var i = 0, r0 = r(1, 2); i < 10000; i++) r0()]),
        closeTo(dvariance(1, 2), 0.05));
    expect(variance([for (var i = 0, r0 = r(2, 1); i < 10000; i++) r0()]),
        closeTo(dvariance(2, 1), 0.05));
    expect(variance([for (var i = 0, r0 = r(3, 4); i < 10000; i++) r0()]),
        closeTo(dvariance(3, 4), 0.05));
    expect(variance([for (var i = 0, r0 = r(0.5, 0.5); i < 10000; i++) r0()]),
        closeTo(dvariance(0.5, 0.5), 0.05));
    expect(variance([for (var i = 0, r0 = r(2.7, 0.3); i < 10000; i++) r0()]),
        closeTo(dvariance(2.7, 0.3), 0.05));
  });
}
