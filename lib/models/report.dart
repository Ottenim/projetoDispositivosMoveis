class Report {
  final String? userName;
  final String? userCpf;
  final double? totalValue;
  final int? totalDuration;

  Report({
    required this.userName,
    required this.userCpf,
    required this.totalValue,
    required this.totalDuration,
  });

  Report copyWith({
    String? id,
    String? name,
    double? value,
    String? info,
    int? duration,
  }) {
    return Report(
      userName: userName ?? this.userName,
      userCpf: userCpf ?? this.userCpf,
      totalValue: totalValue ?? this.totalValue,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }

  @override
  List<Object?> get props => [userName, userCpf, totalValue, totalDuration];
}
