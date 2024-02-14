import 'dart:math';

import 'default_source.dart';

// https://en.wikipedia.org/wiki/Linear_congruential_generator#Parameters_in_common_use
const mul = 0x19660D;
const inc = 0x3C6EF35F;
const eps = 1 / 0x100000000;

/// Returns a
/// [linear congruential generator](https://en.wikipedia.org/wiki/Linear_congruential_generator);
/// this function can be called repeatedly to obtain pseudorandom values
/// well-distributed on the interval [0,1) and with a long period (up to 1
/// billion numbers), similar to [Random.nextDouble].
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
///                 Plot.dotX(Array.from({length: 1000}, d3.randomLcg(36)), Plot.dodgeY({clip: true, r: 2, fill: "currentColor"}))
///             ]
///         });
///     }
/// </script>
///
/// ```dart
/// randomLcg(42)
/// ```
///
/// A [seed] can be specified as a real number in the interval [0,1) or as any
/// integer. In the latter case, only the lower 32 bits are considered. Two
/// generators instanced with the same seed generate the same sequence, allowing
/// to create reproducible pseudo-random experiments. If the [seed] is not
/// specified, one is chosen using [Random.nextDouble]..
num Function() randomLcg([num? seed]) {
  seed ??= defaultSource();
  var state = (0 <= seed && seed < 1 ? seed / eps : seed.abs()).truncate();
  return () {
    state = (mul * state + inc).truncate();
    state = (state & 0x7fffffff) - (state & 0x80000000);
    return eps * (state >= 0 ? state : state & ((1 << 32) - 1));
  };
}
