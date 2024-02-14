import 'dart:math';

import 'default_source.dart';
import 'normal.dart';

/// Returns a [randomLogNormal] function but where the given random number
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
/// final random = randomLogNormalSource(randomLcg(seed))(…);
/// ```
num Function() Function([num, num]) randomLogNormalSource(
    num Function() source) {
  var N = randomNormalSource(source);

  return ([num mu = 0, num sigma = 1]) {
    var randomNormal = N(mu, sigma);
    return () {
      return exp(randomNormal());
    };
  };
}

final _randomLogNormal = randomLogNormalSource(defaultSource);

/// Returns a function for generating random numbers with a
/// [log-normal distribution](https://en.wikipedia.org/wiki/Log-normal_distribution).
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
///                 Plot.dotX(Array.from({length: 400}, d3.randomLogNormal.source(d3.randomLcg(36))(0, 1)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomLogNormal(0, 1)
/// ```
///
/// The expected value of the random variable’s natural logarithm is [mu], with
/// the given standard deviation [sigma]. If [mu] is not specified, it defaults
/// to 0; if [sigma] is not specified, it defaults to 1.
num Function() randomLogNormal([num mu = 0, num sigma = 1]) {
  return _randomLogNormal(mu, sigma);
}
