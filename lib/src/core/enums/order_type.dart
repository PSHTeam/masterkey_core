enum OrderType {
  byName,
  byCreationTime,
  byLastModified;

  factory OrderType.fromIndex(int? index) {
    return OrderType.values.firstWhere(
      (element) => element.index == index,
      orElse: () => OrderType.byLastModified,
    );
  }
}
