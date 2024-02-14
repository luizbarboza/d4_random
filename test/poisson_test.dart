import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

import 'statistics.dart';

void main() {
  // Ten times the default number of samples are taken for the lambda = 0.001 tests,
  // since otherwise the very small expected number of non-zero samples would
  // wildly influence summary statistics.

  test("randomPoisson(lambda) returns random numbers with a mean of lambda",
      () {
    final r = randomPoissonSource(randomLcg(0.48758044703454373));
    expect(mean([for (var i = 0, r0 = r(0.001); i < 100000; i++) r0()]),
        closeTo(0.001, 0.0005));
    expect(mean([for (var i = 0, r0 = r(0.1); i < 10000; i++) r0()]),
        closeTo(0.1, 0.01));
    expect(mean([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(0.5, 0.05));
    expect(mean([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(1, 0.05));
    expect(mean([for (var i = 0, r0 = r(2); i < 10000; i++) r0()]),
        closeTo(2, 0.1));
    expect(mean([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(10, 0.5));
    expect(mean([for (var i = 0, r0 = r(1000); i < 10000; i++) r0()]),
        closeTo(1000, 20));
  });

  test("randomPoisson(lambda) returns random numbers with a variance of lambda",
      () {
    final r = randomPoissonSource(randomLcg(0.4777559867161436));
    expect(variance([for (var i = 0, r0 = r(0.001); i < 100000; i++) r0()]),
        closeTo(0.001, 0.0005));
    expect(variance([for (var i = 0, r0 = r(0.1); i < 10000; i++) r0()]),
        closeTo(0.1, 0.01));
    expect(variance([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(0.5, 0.05));
    expect(variance([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(1, 0.05));
    expect(variance([for (var i = 0, r0 = r(2); i < 10000; i++) r0()]),
        closeTo(2, 0.1));
    expect(variance([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(10, 0.5));
    expect(variance([for (var i = 0, r0 = r(1000); i < 10000; i++) r0()]),
        closeTo(1000, 20));
  });

  test(
      "randomPoisson(lambda) returns random numbers with a skewness of 1 / sqrt(lambda)",
      () {
    final r = randomPoissonSource(randomLcg(0.09357670133206075));
    expect(skewness([for (var i = 0, r0 = r(0.001); i < 100000; i++) r0()]),
        closeTo(31.6, 5));
    expect(skewness([for (var i = 0, r0 = r(0.1); i < 10000; i++) r0()]),
        closeTo(3.16, 0.2));
    expect(skewness([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(1.414, 0.1));
    expect(skewness([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(1, 0.1));
    expect(skewness([for (var i = 0, r0 = r(2); i < 10000; i++) r0()]),
        closeTo(0.707, 0.05));
    expect(skewness([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(0.316, 0.05));
    expect(skewness([for (var i = 0, r0 = r(1000); i < 10000; i++) r0()]),
        closeTo(0.0316, 0.05));
  });

  test(
      "randomPoisson(lambda) returns random numbers with a kurtosis excess of 1 / lambda",
      () {
    final r = randomPoissonSource(randomLcg(0.3299530136090847));
    expect(kurtosis([for (var i = 0, r0 = r(0.001); i < 100000; i++) r0()]),
        closeTo(1000, 200));
    expect(kurtosis([for (var i = 0, r0 = r(0.1); i < 10000; i++) r0()]),
        closeTo(10, 2));
    expect(kurtosis([for (var i = 0, r0 = r(0.5); i < 10000; i++) r0()]),
        closeTo(2, 0.5));
    expect(kurtosis([for (var i = 0, r0 = r(1); i < 10000; i++) r0()]),
        closeTo(1, 0.5));
    expect(kurtosis([for (var i = 0, r0 = r(2); i < 10000; i++) r0()]),
        closeTo(0.5, 0.2));
    expect(kurtosis([for (var i = 0, r0 = r(10); i < 10000; i++) r0()]),
        closeTo(0.1, 0.1));
    expect(kurtosis([for (var i = 0, r0 = r(1000); i < 10000; i++) r0()]),
        closeTo(0.001, 0.1));
  });
}
