enum ProgressStep {
  fetchStatistics,
  passwords,
  collections,
  cards,
  wallets,
  success;

  bool get isFetchStatistics => this == fetchStatistics;
  bool get isPasswords => this == passwords;
  bool get isCategories => this == collections;
  bool get isCards => this == cards;
  bool get isWallets => this == wallets;
  bool get isSuccess => this == success;
}
