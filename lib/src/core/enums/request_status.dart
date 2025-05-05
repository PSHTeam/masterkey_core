enum RequestStatus {
  loading,
  loadingMore,
  archiving,
  deleting,
  loaded,
  idle,
  error;

  bool get isLoading => this == loading;
  bool get isLoadingMore => this == loadingMore;
  bool get isArchiving => this == archiving;
  bool get isDeleting => this == deleting;
  bool get isLoaded => this == loaded;
  bool get isError => this == error;
  bool get isIdle => this == idle;
}
