String getEmployeeStatus(int totalDays, int remainDays, int progressDays) {
  final totalPeriod = totalDays;
  final remainPeriod = remainDays;
  final progressPeriod = progressDays;

  if (remainPeriod <= 0) {
    return '정식사원';
  } else if (progressPeriod >= (totalPeriod / 2) - 1) {
    return '수습';
  } else {
    return '인턴';
  }
}
