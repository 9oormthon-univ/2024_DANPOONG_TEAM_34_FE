class PeriodState {
  late final int contractPeriod;
  late final int progressPeriod;
  late final int remainPeriod;

  PeriodState({
    required this.contractPeriod,
    required this.progressPeriod,
    required this.remainPeriod,
  });

  PeriodState copyWith({
    int? contractPeriod,
    int? progressPeriod,
    int? remainPeriod,
  }) {
    return PeriodState(
      contractPeriod: contractPeriod ?? this.contractPeriod,
      progressPeriod: progressPeriod ?? this.progressPeriod,
      remainPeriod: remainPeriod ?? this.remainPeriod,
    );
  }

  factory PeriodState.initial() {
    return PeriodState(
      contractPeriod: 0,
      progressPeriod: 0,
      remainPeriod: 0,
    );
  }

  factory PeriodState.fromJson(Map<String, dynamic> data) {
    return PeriodState(
      contractPeriod: data['contractPeriod'] as int,
      progressPeriod: data['progressPeriod'] as int,
      remainPeriod: data['remainPeriod'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contractPeriod': contractPeriod,
      'progressPeriod': progressPeriod,
      'remainPeriod': remainPeriod,
    };
  }
}
