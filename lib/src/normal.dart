import 'dart:math';

import 'default_source.dart';

/// Returns a [randomNormal] function but where the given random number
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
/// final random = randomNormalSource(randomLcg(seed))(…);
/// ```
num Function() Function([num, num]) randomNormalSource(num Function() source) {
  return ([num mu = 0, num sigma = 1]) {
    num? x, r;
    return () {
      num y;

      // If available, use the second previously-generated uniform random.
      if (x != null) {
        y = x!;
        x = null;
      }

      // Otherwise, generate a new x and y.
      else {
        do {
          x = source() * 2 - 1;
          y = source() * 2 - 1;
          r = x! * x! + y * y;
        } while ((r == 0) || r! > 1);
      }

      return mu + sigma * y * sqrt(-2 * log(r!) / r!);
    };
  };
}

final _randomNormal = randomNormalSource(defaultSource);

/// Returns a function for generating random numbers with a
/// [normal (Gaussian) distribution](https://en.wikipedia.org/wiki/Normal_distribution).
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
///                 Plot.dotX(Array.from({length: 1000}, d3.randomNormal.source(d3.randomLcg(42))(0, 1)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomNormal(0, 1) // mean of 0, and standard deviation of 1
/// ```
///
/// The expected value of the generated numbers is [mu], with the given standard
/// deviation [sigma]. If [mu] is not specified, it defaults to 0; if [sigma] is
/// not specified, it defaults to 1.
num Function() randomNormal([num mu = 0, num sigma = 1]) {
  return _randomNormal(mu, sigma);
}
