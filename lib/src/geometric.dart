import 'dart:math';

import 'default_source.dart';

/// Returns a [randomGeometric] function but where the given random number
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
/// final random = randomGeometricSource(randomLcg(seed))(…);
/// ```
num Function() Function(num) randomGeometricSource(num Function() source) {
  return (num p) {
    if (p < 0 || p > 1) throw RangeError.range(p, 0, 1, "p");
    if (p == 0) return () => double.infinity;
    if (p == 1) return () => 1;
    p = log(1 - p);
    return () {
      return 1 + (log(1 - source()) / p).floor();
    };
  };
}

final _randomGeometric = randomGeometricSource(defaultSource);

/// Returns a function for generating numbers with a
/// [geometric distribution](https://en.wikipedia.org/wiki/Geometric_distribution)
/// with success probability [p].
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
///             height: 240,
///             nice: true,
///             marks: [
///                 Plot.dotX(Array.from({length: 400}, d3.randomGeometric.source(d3.randomLcg(36))(0.1)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomGeometric(0.1)
/// ```
///
/// The value [p] is in the range \[0, 1\].
num Function() randomGeometric(num p) {
  return _randomGeometric(p);
}
