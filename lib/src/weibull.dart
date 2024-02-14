import 'dart:math';

import 'default_source.dart';

/// Returns a [randomWeibull] function but where the given random number
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
/// final random = randomWeibullSource(randomLcg(seed))(…);
/// ```
num Function() Function(num, [num, num]) randomWeibullSource(
    num Function() source) {
  return (num k, [num a = 0, num b = 1]) {
    final num Function(num) outerFunc;
    if (k == 0) {
      outerFunc = (x) => -log(x);
    } else {
      k = 1 / k;
      outerFunc = (x) => pow(x, k);
    }
    return () {
      return a + b * outerFunc(-log(1 - source()));
    };
  };
}

final _randomWeibull = randomWeibullSource(defaultSource);

/// Returns a function for generating random numbers with one of the
/// [generalized extreme value distributions](https://en.wikipedia.org/wiki/Generalized_extreme_value_distribution),
/// depending on [k]\:
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
///                 Plot.dotX(Array.from({length: 1000}, d3.randomWeibull.source(d3.randomLcg(36))(10)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomWeibull(10)
/// ```
///
/// * If [k] is positive, the
/// [Weibull distribution](https://en.wikipedia.org/wiki/Weibull_distribution)
/// with shape parameter [k]
/// * If [k] is zero, the
/// [Gumbel distribution](https://en.wikipedia.org/wiki/Gumbel_distribution)
/// * If [k] is negative, the
/// [Fréchet distribution](https://en.wikipedia.org/wiki/Fréchet_distribution)
/// with shape parameter −[k]
///
/// In all three cases, [a] is the location parameter and [b] is the scale
/// parameter. If [a] is not specified, it defaults to 0; if [b] is not
/// specified, it defaults to 1.
num Function() randomWeibull(num k, [num a = 0, num b = 1]) {
  return _randomWeibull(k, a, b);
}
