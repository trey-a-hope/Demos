// https://docs.bongthorn.dev/pl/learn-dart-first-step-to-flutter/operators/an-introduction-to-operators
// Infix Operators

part of '../home_page.dart';

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}
