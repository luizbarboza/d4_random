import 'dart:math';

import 'default_source.dart';

/// Returns a [randomLogistic] function but where the given random number
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
/// final random = randomLogisticSource(randomLcg(seed))(…);
/// ```
num Function() Function([num, num]) randomLogisticSource(
    num Function() source) {
  return ([num a = 0, num b = 1]) {
    return () {
      var u = source();
      return a + b * log(u / (1 - u));
    };
  };
}

final _randomLogistic = randomLogisticSource(defaultSource);

/// Returns a function for generating random numbers with a
/// [logistic distribution](https://en.wikipedia.org/wiki/Logistic_distribution).
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
///             height: 300,
///             nice: true,
///             marks: [
///                 Plot.dotX(Array.from({length: 1000}, d3.randomLogistic.source(d3.randomLcg(36))(0, 1)), Plot.dodgeY({clip: true, r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomLogistic(0, 1)
/// ```
///
/// [a] and [b] have the same meanings and default values as in randomWeibull.
num Function() randomLogistic([num a = 0, num b = 1]) {
  return _randomLogistic(a, b);
}
