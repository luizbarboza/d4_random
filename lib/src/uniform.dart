import 'dart:math';

import 'default_source.dart';

/// Returns a [randomUniform] function but where the given random number
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
/// final random = randomUniformSource(randomLcg(seed))(…);
/// ```
num Function() Function({num min, num max}) randomUniformSource(
    num Function() source) {
  return ({num min = 0, num max = 1}) {
    max -= min;
    return () {
      return source() * max + min;
    };
  };
}

final _randomUniform = randomUniformSource(defaultSource);

/// Returns a function for generating random numbers with a
/// [uniform distribution](https://en.wikipedia.org/wiki/Uniform_distribution_(continuous)).
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
///             nice: true,
///             marks: [
///                 Plot.dotX(Array.from({length: 1000}, d3.randomUniform.source(d3.randomLcg(42))(6)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomUniform(max: 6) // generate numbers ≥0 and <6
/// ```
///
/// The minimum allowed value of a returned number is [min] (inclusive), and the
/// maximum is [max] (exclusive). If [min] is not specified, it defaults to 0;
/// if [max] is not specified, it defaults to 1.
num Function() randomUniform({num min = 0, num max = 1}) {
  return _randomUniform(min: min, max: max);
}
