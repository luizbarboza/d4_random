import 'dart:math';

import 'default_source.dart';

/// Returns a [randomExponential] function but where the given random number
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
/// final random = randomExponentialSource(randomLcg(seed))(…);
/// ```
num Function() Function(num) randomExponentialSource(num Function() source) {
  return (num lambda) {
    return () {
      return -log(1 - source()) / lambda;
    };
  };
}

final _randomExponential = randomExponentialSource(defaultSource);

/// Returns a function for generating random numbers with an
/// [exponential distribution](https://en.wikipedia.org/wiki/Exponential_distribution)
/// with the rate [lambda]; equivalent to time between events in a
/// [Poisson process](https://en.wikipedia.org/wiki/Poisson_point_process) with
/// a mean of 1 / [lambda].
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
///             height: 190,
///             nice: true,
///             marks: [
///                 Plot.dotX(Array.from({length: 600}, d3.randomExponential.source(d3.randomLcg(36))(1 / 40)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomExponential(1 / 40)
/// ```
///
/// For example, randomExponential(1 / 40) generates random times between events
/// where, on average, one event occurs every 40 units of time.
num Function() randomExponential(num lambda) {
  return _randomExponential(lambda);
}
