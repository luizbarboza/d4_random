import 'dart:math';

import 'default_source.dart';

/// Returns a [randomIrwinHall] function but where the given random number
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
/// final random = randomIrwinHallSource(randomLcg(seed))(…);
/// ```
num Function() Function(num) randomIrwinHallSource(num Function() source) {
  return (num n) {
    if (n <= 0) return () => 0;
    return () {
      num sum = 0;
      var i = n;
      for (; i > 1; --i) {
        sum += source();
      }
      return sum + i * source();
    };
  };
}

final _randomIrwinHall = randomIrwinHallSource(defaultSource);

/// Returns a function for generating random numbers with an
/// [Irwin–Hall distribution](https://en.wikipedia.org/wiki/Irwin–Hall_distribution)
/// with [n] independent variables.
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
///                 Plot.dotX(Array.from({length: 1000}, d3.randomIrwinHall.source(d3.randomLcg(36))(3)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomIrwinHall(3) // generates numbers between 0 and 3
/// ```
///
/// If the fractional part of [n] is non-zero, this is treated as adding
/// randomUniform() times that fractional part to the integral part.).
num Function() randomIrwinHall(num n) {
  return _randomIrwinHall(n);
}
