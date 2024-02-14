import 'dart:math';

import 'package:d4_array/d4_array.dart';
import 'package:d4_random/d4_random.dart';
import 'package:test/test.dart';

void main() {
  test(
      "randomExponential(lambda) returns random exponentially distributed numbers with a mean of 1/lambda.",
      () {
    final r = randomExponentialSource(randomLcg(0.42));
    const period = 20;
    const lambda = 1 / period; // average rate (e.g. 1 per 20 minutes)
    final times = [for (var i = 0, r0 = r(lambda); i < 10000; i++) r0()];

    expect(mean(times), closeTo(period, period * 0.05));

    // Test cumulative distribution in intervals of 10.
    range(start: 10, stop: 100, step: 10).forEach((elapsed) {
      final within = times.where((t) => t <= elapsed);
      final expected = 1 - exp(-elapsed * lambda);
      expect(within.length / times.length, closeTo(expected, expected * 0.02));
    });
  });
}
