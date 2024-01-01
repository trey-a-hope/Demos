extension BooleanMultiplication on bool {
  bool operator *(bool other) {
    final shadow = this;

    if ((shadow && other) || (!shadow && !other)) {
      return true;
    } else {
      return false;
    }
  }
}
