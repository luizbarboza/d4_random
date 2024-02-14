import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

void main() {
  // Since the Cauchy distribution is "pathological" in that no integral moments exist,
  // we simply test for the median, equivalent to the location parameter.
  test("randomCauchy(a, b) returns random numbers with a median of a", () {
    final r = randomCauchySource(randomLcg(0.42));
    expect(median([for (var i = 0, r0 = r(); i < 10000; i++) r0()]),
        closeTo(0, 0.05));
    expect(median([for (var i = 0, r0 = r(5); i < 10000; i++) r0()]),
        closeTo(5, 0.05));
    expect(median([for (var i = 0, r0 = r(0, 4); i < 10000; i++) r0()]),
        closeTo(0, 0.1));
    expect(median([for (var i = 0, r0 = r(1, 3); i < 10000; i++) r0()]),
        closeTo(1, 0.1));
    expect(median([for (var i = 0, r0 = r(3, 1); i < 10000; i++) r0()]),
        closeTo(3, 0.05));
  });
}
