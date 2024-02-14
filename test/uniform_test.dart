import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

void main() {
  test("randomUniform() returns random numbers with a mean of 0.5", () {
    final r = randomUniformSource(randomLcg(0.5233099016390388));
    expect(mean([for (var i = 0, r0 = r(); i < 10000; i++) r0()]),
        closeTo(0.5, 0.05));
  });

  test("randomUniform() returns random numbers within the range [0,1)", () {
    final r = randomUniformSource(randomLcg(0.6458793845385908));
    expect(min([for (var i = 0, r0 = r(); i < 10000; i++) r0()]),
        greaterThanOrEqualTo(0));
    expect(min([for (var i = 0, r0 = r(); i < 10000; i++) r0()]), lessThan(1));
  });

  test("randomUniform(max) returns random numbers with a mean of max / 2", () {
    final r = randomUniformSource(randomLcg(0.678948531603278));
    expect(mean([for (var i = 0, r0 = r(max: 42); i < 10000; i++) r0()]),
        closeTo(21, 0.5));
  });

  test("randomUniform(max) returns random numbers within the range [0,max)",
      () {
    final r = randomUniformSource(randomLcg(0.48468185818988196));
    expect(min([for (var i = 0, r0 = r(max: 42); i < 10000; i++) r0()]),
        greaterThanOrEqualTo(0));
    expect(min([for (var i = 0, r0 = r(max: 42); i < 10000; i++) r0()]),
        lessThan(42));
  });

  test(
      "randomUniform(min, max) returns random numbers with a mean of (min + max) / 2",
      () {
    final r = randomUniformSource(randomLcg(0.23751000425183233));
    expect(mean([for (var i = 0, r0 = r(min: 10, max: 42); i < 10000; i++) r0()]), closeTo(26, 0.5));
  });

  test(
      "randomUniform(min, max) returns random numbers within the range [min,max)",
      () {
    final r = randomUniformSource(randomLcg(0.3607454145271254));
    expect(min([for (var i = 0, r0 = r(min: 10, max: 42); i < 10000; i++) r0()]), greaterThanOrEqualTo(10));
    expect(min([for (var i = 0, r0 = r(min: 10, max: 42); i < 10000; i++) r0()]), lessThan(42));
  });
}
