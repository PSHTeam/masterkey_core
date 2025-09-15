enum HomePasswordsType {
  unsorted,
  allPasswords;

  bool get isUnsorted => this == unsorted;
  bool get isAllPasswords => this == allPasswords;
}
