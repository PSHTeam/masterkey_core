enum TableType {
  passwords,
  cards,
  wallets,
  all;

  bool get isPassword => this == passwords;
  bool get isCard => this == cards;
  bool get isWallet => this == wallets;
  bool get isAll => this == all;
}
