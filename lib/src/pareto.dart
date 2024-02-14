import 'dart:math';

import 'default_source.dart';

/// Returns a [randomPareto] function but where the given random number
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
/// final random = randomParetoSource(randomLcg(seed))(…);
/// ```
num Function() Function(num) randomParetoSource(num Function() source) {
  return (num alpha) {
    if (alpha < 0) throw RangeError.range(alpha, 0, null, "alpha");
    alpha = 1 / -alpha;
    return () {
      return pow(1 - source(), alpha);
    };
  };
}

final _randomPareto = randomParetoSource(defaultSource);

/// Returns a function for generating random numbers with a
/// [Pareto distribution](https://en.wikipedia.org/wiki/Pareto_distribution)
/// with the shape [alpha].
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
///             height: 210,
///             nice: true,
///             marks: [
///                 Plot.dotX(Array.from({length: 400}, d3.randomPareto.source(d3.randomLcg(36))(6)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomPareto(6)
/// ```
///
/// The value [alpha] must be a positive value.
num Function() randomPareto(num alpha) {
  return _randomPareto(alpha);
}
