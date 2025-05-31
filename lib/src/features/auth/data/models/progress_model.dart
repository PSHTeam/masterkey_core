import 'package:masterkey_core/src/src.dart' show Progress, ProgressStep;

class ProgressModel extends Progress {
  const ProgressModel({
    super.total,
    super.percent,
    super.doneItems,
    super.totalItems,
    required super.step,
  });

  Progress toEntity() => Progress(
    total: total,
    percent: percent,
    doneItems: doneItems,
    totalItems: doneItems,
    step: step,
  );

  ProgressModel copyWith({
    int? total,
    double? percent,
    ProgressStep? step,
    int? doneItems,
    int? totalItems,
  }) {
    return ProgressModel(
      total: total ?? this.total,
      percent: percent ?? this.percent,
      step: step ?? this.step,
      doneItems: doneItems ?? this.doneItems,
      totalItems: totalItems ?? totalItems,
    );
  }
}
