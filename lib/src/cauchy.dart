import 'dart:math';

import 'default_source.dart';

/// Returns a [randomCauchy] function but where the given random number
/// generator [source] is used as the source of randomness instead of
/// [Random.nextDouble].
///
/// The given random number generator must implement the same interface as
/// [Random.nextDouble] and only return values in the range \[0, 1\). This is
/// useful when a seeded random number generator is preferable to
/// [Random.nextDouble].
///
/// ```dart
/// final seed = …; // any number in [0, 1)
/// final random = randomCauchySource(randomLcg(seed))(…);
/// ```
num Function() Function([num, num]) randomCauchySource(num Function() source) {
  return ([num a = 0, num b = 1]) {
    return () {
      return a + b * tan(pi * source());
    };
  };
}

final _randomCauchy = randomCauchySource(defaultSource);

/// Returns a function for generating random numbers with a
/// [Cauchy distribution](https://en.wikipedia.org/wiki/Cauchy_distribution).
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
///             x: {domain: [-5, 5]},
///             marks: [
///                 Plot.dotX(Array.from({length: 1000}, d3.randomCauchy.source(d3.randomLcg(36))(0, 1)), Plot.dodgeY({clip: true, r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomCauchy(0, 1) // above, clipped to [-5, 5] because “fat tails”
/// ```
///
/// [a] and [b] have the same meanings and default values as in randomWeibull.
num Function() randomCauchy([num a = 0, num b = 1]) {
  return _randomCauchy(a, b);
}
