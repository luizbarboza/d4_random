import 'dart:math';

import 'default_source.dart';

/// Returns a [randomBernoulli] function but where the given random number
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
/// final random = randomBernoulliSource(randomLcg(seed))(…);
/// ```
int Function() Function(num) randomBernoulliSource(num Function() source) {
  return (num p) {
    if (p < 0 || p > 1) throw RangeError.range(p, 0, 1, "p");
    return () {
      return (source() + p).floor();
    };
  };
}

final _randomBernoulli = randomBernoulliSource(defaultSource);

/// Returns a function for generating either 1 or 0 according to a
/// [Bernoulli distribution](https://en.wikipedia.org/wiki/Binomial_distribution)
/// with 1 being returned with success probability [p] and 0 with failure
/// probability *q* = 1 - [p].
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
///             height: 120,
///             width: 60,
///             x: {ticks: 1},
///             nice: true,
///             marks: [
///                 Plot.dotX(Array.from({length: 34}, d3.randomBernoulli.source(d3.randomLcg(36))(0.5)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomBernoulli(0.5)
/// ```
///
/// The value [p] is in the range \[0, 1\].
int Function() randomBernoulli(num p) {
  return _randomBernoulli(p);
}
