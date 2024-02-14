import 'dart:math';

import 'default_source.dart';
import 'gamma.dart';

/// Returns a [randomBeta] function but where the given random number generator
/// [source] is used as the source of randomness instead of [Random.nextDouble].
///
/// The given random number generator must implement the same interface as
/// [Random.nextDouble] and only return values in the range \[0, 1\). This is
/// useful when a seeded random number generator is preferable to
/// [Random.nextDouble].
///
/// ```dart
/// final seed = …; // any number in [0, 1)
/// final random = randomBetaSource(randomLcg(seed))(…);
/// ```
num Function() Function(num, num) randomBetaSource(num Function() source) {
  var G = randomGammaSource(source);

  return (num alpha, num beta) {
    var X = G(alpha), Y = G(beta);
    return () {
      var x = X();
      return x == 0 ? 0 : x / (x + Y());
    };
  };
}

final _randomBeta = randomBetaSource(defaultSource);

/// Returns a function for generating random numbers with a
/// [beta distribution](https://en.wikipedia.org/wiki/Beta_distribution) with
/// [alpha] and [beta] shape parameters, which must both be positive.
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
///             height: 160,
///             nice: true,
///             marks: [
///                 Plot.dotX(Array.from({length: 1000}, d3.randomBeta.source(d3.randomLcg(36))(3, 1.5)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomBeta(3, 1.5)
/// ```
num Function() randomBeta(num alpha, num beta) {
  return _randomBeta(alpha, beta);
}
