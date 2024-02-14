import 'dart:math';

import 'package:d4_array/d4_array.dart';

num kurtosis(List<num> numbers) {
  num m = mean(numbers)!, sum4 = 0, sum2 = 0, v;
  int i = -1, n = numbers.length;

  while (++i < n) {
    v = numbers[i] - m;
    sum2 += v * v;
    sum4 += v * v * v * v;
  }

  return (1 / n) * sum4 / pow((1 / n) * sum2, 2) - 3;
}

num skewness(List<num> numbers) {
  num m = mean(numbers)!, sum3 = 0, sum2 = 0, v;
  int i = -1, n = numbers.length;

  while (++i < n) {
    v = numbers[i] - m;
    sum2 += v * v;
    sum3 += v * v * v;
  }

  return (1 / n) * sum3 / pow((1 / (n - 1)) * sum2, 3 / 2);
}
