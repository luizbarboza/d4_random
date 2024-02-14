import 'dart:math';
import 'dart:typed_data';

import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

void main() {
  test("lcg is the expected deterministic PRNG", () {
    const r1 = 0.6678668977692723;
    final lcg1 = randomLcg(0);
    expect((lcg1(), lcg1(), lcg1(), lcg1()).$4, closeTo(r1, 1e-16));
    final lcg2 = randomLcg(0);
    expect((lcg2(), lcg2(), lcg2(), lcg2()).$4, closeTo(r1, 1e-16));
  });

  test("lcg is seeded", () {
    const seed = 0.42;
    const r42 = 0.6760216606780887;
    final lcg = randomLcg(seed);
    expect((lcg(), lcg(), lcg(), lcg()).$4, closeTo(r42, 1e-16));
  });

  test("lcg is well-distributed", () {
    const seed = 0.2; // 1…11 are ok
    final lcg = randomLcg(seed);
    final run =
        Float32List.fromList(List.generate(10000, (_) => lcg().toDouble()));
    expect(mean(run), closeTo(1 / 2, 1e-2));
    expect(deviation(run), closeTo(sqrt(1 / 12), 1e-2));
    final histogram = rollup(run, (v) => v.length, (d) => (d * 10).floor());
    for (var MapEntry(:value) in histogram.entries) {
      expect(value, closeTo(1000, 120));
    }
  });

  test("lcg with small fractional seeds is well-distributed", () {
    final G = List.generate(100, (i) => randomLcg(i / 100));
    final means = <num?>[], variances = <num?>[];
    for (var i = 0; i < 10; i++) {
      final M = G.map((d) => d());
      means.add(mean(M));
      variances.add(variance(M));
    }
    expect(mean(means), closeTo(0.5, 0.02));
    expect(min(variances), greaterThan(0.75 / 12));
  });
}
