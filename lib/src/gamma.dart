import 'dart:math';

import 'default_source.dart';
import 'normal.dart';

/// Returns a [randomGamma] function but where the given random number generator
/// [source] is used as the source of randomness instead of [Random.nextDouble].
///
/// The given random number generator must implement the same interface as
/// [Random.nextDouble] and only return values in the range \[0, 1\). This is
/// useful when a seeded random number generator is preferable to
/// [Random.nextDouble].
///
/// ```dart
/// final seed = …; // any number in [0, 1)
/// final random = randomGammaSource(randomLcg(seed))(…);
/// ```
num Function() Function(num, [num]) randomGammaSource(num Function() source) {
  final randomNormal = randomNormalSource(source)();

  return (num k, [num theta = 1]) {
    if (k < 0) throw RangeError.range(k, 0, null, "k");
    // degenerate distribution if k === 0
    if (k == 0) return () => 0;
    // exponential distribution if k === 1
    if (k == 1) return () => -log(1 - source()) * theta;

    var d = (k < 1 ? k + 1 : k) - 1 / 3,
        c = 1 / (3 * sqrt(d)),
        multiplier = k < 1 ? () => pow(source(), 1 / k) : () => 1;
    return () {
      num x, u, v;
      do {
        do {
          x = randomNormal();
          v = 1 + c * x;
        } while (v <= 0);
        v *= v * v;
        u = 1 - source();
      } while (u >= 1 - 0.0331 * x * x * x * x &&
          log(u) >= 0.5 * x * x + d * (1 - v + log(v)));
      return d * v * multiplier() * theta;
    };
  };
}

final _randomGamma = randomGammaSource(defaultSource);

/// Returns a function for generating random numbers with a
/// [gamma distribution](https://en.wikipedia.org/wiki/Gamma_distribution) with
/// [k] the shape parameter and [theta] the scale parameter.
///
/// <div id="obs">
///     <div id="in"></div>
///     <div id="out"></div>
/// </div>
///
/// <script type="module">
///
///     import { Runtime, Inspector } from "https://cdn.jsdelivr.net/npm/@observablehq/runtime@5/dist/runtime.js";
///     import * as d3 from "https://cdn.jsdelivr.net/npm/d3@7/+esm";
///     import * as Plot from "https://cdn.jsdelivr.net/npm/@observablehq/plot@0.6/+esm";
///
///     const obs = d3.select("#obs");
///
///     const runtime = new Runtime();
///     const module = runtime.module();
///     const inspector = new Inspector(obs.select("#out").node());
///
///     module.variable(inspector).define("out", definition);
///
///     function definition() {
///         return Plot.plot({
///             height: 200,
///             nice: true,
///             marks: [
///                 Plot.dotX(Array.from({length: 1000}, d3.randomGamma.source(d3.randomLcg(36))(2, 1)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomGamma(2, 1)
/// ```
///
/// The value [k] must be a positive value; if [theta] is not specified, it
/// defaults to 1.
num Function() randomGamma(num k, [num theta = 1]) {
  return _randomGamma(k, theta);
}
