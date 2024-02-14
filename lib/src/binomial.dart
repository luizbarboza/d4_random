import 'dart:math';

import 'beta.dart';
import 'default_source.dart';
import 'geometric.dart';

/// Returns a [randomBinomial] function but where the given random number
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
/// final random = randomBinomialSource(randomLcg(seed))(…);
/// ```
num Function() Function(num, num) randomBinomialSource(num Function() source) {
  var G = randomGeometricSource(source), B = randomBetaSource(source);

  return (num n, num p) {
    if (p >= 1) return () => n;
    if (p <= 0) return () => 0;
    return () {
      var acc = 0, nn = n, pp = p;
      while (nn * pp > 16 && nn * (1 - pp) > 16) {
        var i = ((nn + 1) * pp).floor(), y = B(i, nn - i + 1)();
        if (y <= pp) {
          acc += i;
          nn -= i;
          pp = (pp - y) / (1 - y);
        } else {
          nn = i - 1;
          pp /= y;
        }
      }
      var sign = pp < 0.5, pFinal = sign ? pp : 1 - pp, g = G(pFinal);
      int k = 0;
      for (var s = g(); s <= nn; ++k) {
        s += g();
      }
      return acc + (sign ? k : nn - k);
    };
  };
}

final _randomBinomial = randomBinomialSource(defaultSource);

/// Returns a function for generating random numbers with a
/// [binomial distribution](https://en.wikipedia.org/wiki/Binomial_distribution)
/// with [n] the number of trials and [p] the probability of success in each
/// trial.
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
///             x: {domain: [0, 40]},
///             marks: [
///                 Plot.dotX(Array.from({length: 300}, d3.randomBinomial.source(d3.randomLcg(36))(40, 0.5)), Plot.dodgeY({r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomBinomial(40, 0.5)
/// ```
///
/// The value [n] is greater or equal to 0, and the value [p] is in the range
/// \[0, 1\].
num Function() randomBinomial(num n, num p) {
  return _randomBinomial(n, p);
}
