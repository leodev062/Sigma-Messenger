enum JobPriority {
  low(0),
  medium(1),
  high(2),
  critical(3);

  final int value;
  const JobPriority(this.value);

  static JobPriority fromInt(int value) {
    return JobPriority.values.firstWhere(
      (e) => e.value == value,
      orElse: () => JobPriority.medium,
    );
  }
}

enum JobNetworkConstraint {
  none,
  any,
  unmetered,
  notRoaming
}
