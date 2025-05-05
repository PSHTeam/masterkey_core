import 'package:equatable/equatable.dart' show Equatable;
import 'package:masterkey_core/src/src.dart' show ProgressStep;

class Progress extends Equatable {
  final int? total;
  final double? percent;
  final int? doneItems;
  final int? totalItems;
  final ProgressStep step;

  const Progress({
    this.percent,
    this.total,
    this.doneItems,
    this.totalItems,
    required this.step,
  });

  factory Progress.initial() {
    return Progress(step: ProgressStep.fetchStatistics);
  }

  @override
  List<Object?> get props => [percent, total, step, doneItems, totalItems];
}
