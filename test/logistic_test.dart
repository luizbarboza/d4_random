import 'dart:math';

import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

import 'statistics.dart';

num dvariance(num a, num b) {
  return pow(pi * b, 2) / 3;
}

void main() {
  test("randomLogistic(a, b) returns random numbers with a mean of a", () {
    final r = randomLogisticSource(randomLcg(0.8792712826844997));
    expect(mean([for (var i = 0, r0 = r(); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
    expect(mean([for (var i = 0, r0 = r(5); i < 10000; i++) r0()]),
        closeTo(5, 0.05));
    expect(mean([for (var i = 0, r0 = r(0, 4); i < 10000; i++) r0()]),
        closeTo(0, 0.1));
    expect(mean([for (var i = 0, r0 = r(1, 3); i < 10000; i++) r0()]),
        closeTo(1, 0.1));
    expect(mean([for (var i = 0, r0 = r(3, 1); i < 10000; i++) r0()]),
        closeTo(3, 0.05));
  });

  test(
      "randomLogistic(a, b) returns random numbers with a variance of (b * pi)^2 / 3",
      () {
    final r = randomLogisticSource(randomLcg(0.5768515852192524));
    expect(variance([for (var i = 0, r0 = r(); i < 10000; i++) r0()]),
        closeTo(dvariance(0, 1), 0.2));
    expect(variance([for (var i = 0, r0 = r(5); i < 10000; i++) r0()]),
        closeTo(dvariance(5, 1), 0.2));
    expect(variance([for (var i = 0, r0 = r(0, 4); i < 10000; i++) r0()]),
        closeTo(dvariance(0, 4), 2));
    expect(variance([for (var i = 0, r0 = r(1, 3); i < 10000; i++) r0()]),
        closeTo(dvariance(1, 3), 2));
    expect(variance([for (var i = 0, r0 = r(3, 1); i < 10000; i++) r0()]),
        closeTo(dvariance(3, 1), 2));
  });

  test("randomLogistic(a, b) returns random numbers with a skewness of zero",
      () {
    final r = randomLogisticSource(randomLcg(0.8835033777589203));
    expect(skewness([for (var i = 0, r0 = r(); i < 10000; i++) r0()]),
        closeTo(0, 0.1));
    expect(skewness([for (var i = 0, r0 = r(5); i < 10000; i++) r0()]),
        closeTo(0, 0.1));
    expect(skewness([for (var i = 0, r0 = r(0, 4); i < 10000; i++) r0()]),
        closeTo(0, 0.1));
    expect(skewness([for (var i = 0, r0 = r(1, 3); i < 10000; i++) r0()]),
        closeTo(0, 0.1));
    expect(skewness([for (var i = 0, r0 = r(3, 1); i < 10000; i++) r0()]),
        closeTo(0, 0.1));
  });

  test(
      "randomLogistic(a, b) returns random numbers with an excess kurtosis of 1.2",
      () {
    final r = randomLogisticSource(randomLcg(0.8738996292947383));
    expect(kurtosis([for (var i = 0, r0 = r(); i < 10000; i++) r0()]),
        closeTo(1.2, 0.6));
    expect(kurtosis([for (var i = 0, r0 = r(5); i < 10000; i++) r0()]),
        closeTo(1.2, 0.6));
    expect(kurtosis([for (var i = 0, r0 = r(0, 4); i < 10000; i++) r0()]),
        closeTo(1.2, 0.6));
    expect(kurtosis([for (var i = 0, r0 = r(1, 3); i < 10000; i++) r0()]),
        closeTo(1.2, 0.6));
    expect(kurtosis([for (var i = 0, r0 = r(3, 1); i < 10000; i++) r0()]),
        closeTo(1.2, 0.6));
  });
}
