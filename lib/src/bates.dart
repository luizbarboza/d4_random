import 'dart:math';

import 'default_source.dart';
import 'irwin_hall.dart';

/// Returns a [randomBates] function but where the given random number generator
/// [source] is used as the source of randomness instead of [Random.nextDouble].
///
/// The given random number generator must implement the same interface as
/// [Random.nextDouble] and only return values in the range \[0, 1\). This is
/// useful when a seeded random number generator is preferable to
/// [Random.nextDouble].
///
/// ```dart
/// final seed = …; // any number in [0, 1)
/// final random = randomBatesSource(randomLcg(seed))(…);
/// ```
num Function() Function(num) randomBatesSource(num Function() source) {
  var I = randomIrwinHallSource(source);

  return (num n) {
    // use limiting distribution at n == 0
    if (n == 0) return source;
    var randomIrwinHall = I(n);
    return () {
      return randomIrwinHall() / n;
    };
  };
}

final _randomBates = randomBatesSource(defaultSource);

/// Returns a function for generating random numbers with a
/// [Bates distribution](https://en.wikipedia.org/wiki/Bates_distribution) with
/// [n] independent variables.
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
///             height: 180,
///             nice: true,
///             marks: [
///                 Plot.dotX(Array.from({length: 1000}, d3.randomBates.source(d3.randomLcg(36))(3)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomBates(3) // generates numbers between 0 and 1
/// ```
///
/// The case of fractional [n] is handled as with randomIrwinHall, and
/// randomBates(0) is equivalent to randomUniform().
num Function() randomBates(num n) {
  return _randomBates(n);
}
