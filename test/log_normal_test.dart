import 'dart:math';

import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

void main() {
  test("randomLogNormal() returns random numbers with a log-mean of zero", () {
    final r = randomLogNormalSource(randomLcg(0.9575554996277458));
    expect(meanBy([for (var i = 0, r0 = r(); i < 10000; i++) r0()], log),
        closeTo(0, 0.05));
  });

  test(
      "randomLogNormal() returns random numbers with a log-standard deviation of one",
      () {
    final r = randomLogNormalSource(randomLcg(0.7369869597887295));
    expect(deviationBy([for (var i = 0, r0 = r(); i < 10000; i++) r0()], log),
        closeTo(1, 0.05));
  });

  test("randomLogNormal(mu) returns random numbers with the specified log-mean",
      () {
    final r = randomLogNormalSource(randomLcg(0.2083455771760374));
    expect(meanBy([for (var i = 0, r0 = r(42); i < 10000; i++) r0()], log),
        closeTo(42, 0.05));
    expect(meanBy([for (var i = 0, r0 = r(-2); i < 10000; i++) r0()], log),
        closeTo(-2, 0.05));
  });

  test(
      "randomLogNormal(mu) returns random numbers with a log-standard deviation of 1",
      () {
    final r = randomLogNormalSource(randomLcg(0.7805370705171648));
    expect(deviationBy([for (var i = 0, r0 = r(42); i < 10000; i++) r0()], log),
        closeTo(1, 0.05));
    expect(deviationBy([for (var i = 0, r0 = r(-2); i < 10000; i++) r0()], log),
        closeTo(1, 0.05));
  });

  test(
      "randomLogNormal(mu, sigma) returns random numbers with the specified log-mean and log-standard deviation",
      () {
    final r = randomLogNormalSource(randomLcg(0.5178163416754684));
    expect(meanBy([for (var i = 0, r0 = r(42, 2); i < 10000; i++) r0()], log),
        closeTo(42, 0.05));
    expect(meanBy([for (var i = 0, r0 = r(-2, 2); i < 10000; i++) r0()], log),
        closeTo(-2, 0.05));
    expect(
        deviationBy([for (var i = 0, r0 = r(42, 2); i < 10000; i++) r0()], log),
        closeTo(2, 0.05));
    expect(
        deviationBy([for (var i = 0, r0 = r(-2, 2); i < 10000; i++) r0()], log),
        closeTo(2, 0.05));
  });
}
