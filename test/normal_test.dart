import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

void main() {
  test("randomNormal() returns random numbers with a mean of zero", () {
    final r = randomNormalSource(randomLcg(0.3193923539476107));
    expect(mean([for (var i = 0, r0 = r(); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
  });

  test("randomNormal() returns random numbers with a standard deviation of one",
      () {
    final r = randomNormalSource(randomLcg(0.5618016004747401));
    expect(deviation([for (var i = 0, r0 = r(); i < 10000; i++) r0()]),
        closeTo(1, 0.05));
  });

  test("randomNormal(mu) returns random numbers with the specified mean", () {
    final r = randomNormalSource(randomLcg(0.22864660166790118));
    expect(mean([for (var i = 0, r0 = r(42); i < 10000; i++) r0()]),
        closeTo(42, 0.05));
    expect(mean([for (var i = 0, r0 = r(-2); i < 10000; i++) r0()]),
        closeTo(-2, 0.05));
  });

  test("randomNormal(mu) returns random numbers with a standard deviation of 1",
      () {
    final r = randomNormalSource(randomLcg(0.1274290504810609));
    expect(deviation([for (var i = 0, r0 = r(42); i < 10000; i++) r0()]),
        closeTo(1, 0.05));
    expect(deviation([for (var i = 0, r0 = r(-2); i < 10000; i++) r0()]),
        closeTo(1, 0.05));
  });

  test(
      "randomNormal(mu, sigma) returns random numbers with the specified mean and standard deviation",
      () {
    final r = randomNormalSource(randomLcg(0.49113635631389463));
    expect(mean([for (var i = 0, r0 = r(42, 2); i < 10000; i++) r0()]),
        closeTo(42, 0.05));
    expect(mean([for (var i = 0, r0 = r(-2, 2); i < 10000; i++) r0()]),
        closeTo(-2, 0.05));
    expect(deviation([for (var i = 0, r0 = r(42, 2); i < 10000; i++) r0()]),
        closeTo(2, 0.05));
    expect(deviation([for (var i = 0, r0 = r(-2, 2); i < 10000; i++) r0()]),
        closeTo(2, 0.05));
  });
}
