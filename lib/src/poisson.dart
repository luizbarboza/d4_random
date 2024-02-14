import 'dart:math';

import 'binomial.dart';
import 'default_source.dart';
import 'gamma.dart';

/// Returns a [randomPoisson] function but where the given random number
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
/// final random = randomPoissonSource(randomLcg(seed))(…);
/// ```
num Function() Function(num) randomPoissonSource(num Function() source) {
  var G = randomGammaSource(source), B = randomBinomialSource(source);

  return (num lambda) {
    return () {
      var acc = 0, l = lambda;
      while (l > 16) {
        var n = (0.875 * l).floor(), t = G(n)();
        if (t > l) return acc + B(n - 1, l / t)();
        acc += n;
        l -= t;
      }
      var k = 0;
      for (var s = -log(1 - source()); s <= l; ++k) {
        s -= log(1 - source());
      }
      return acc + k;
    };
  };
}

final _randomPoisson = randomPoissonSource(defaultSource);

/// Returns a function for generating random numbers with a
/// [Poisson distribution](https://en.wikipedia.org/wiki/Poisson_distribution)
/// with mean [lambda].
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
///             height: 150,
///             nice: true,
///             marks: [
///                 Plot.dotX(Array.from({length: 1000}, d3.randomPoisson.source(d3.randomLcg(36))(400)), Plot.dodgeY({clip: true, r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomPoisson(400)
/// ```
num Function() randomPoisson(num lambda) {
  return _randomPoisson(lambda);
}
