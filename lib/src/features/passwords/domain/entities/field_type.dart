import 'package:flutter/material.dart';

enum FieldType {
  email(icon: Icons.email, keyboardType: TextInputType.emailAddress),
  username(icon: Icons.person, keyboardType: TextInputType.text),
  password(icon: Icons.password, keyboardType: TextInputType.text),
  website(icon: Icons.language_outlined, keyboardType: TextInputType.url),
  number(icon: Icons.format_list_numbered, keyboardType: TextInputType.phone),
  pin(icon: Icons.pin, keyboardType: TextInputType.phone),
  dateYMD(icon: Icons.calendar_today, keyboardType: TextInputType.datetime),
  ipAddress(icon: Icons.terminal, keyboardType: TextInputType.phone),
  phone(icon: Icons.phone, keyboardType: TextInputType.phone),
  address(
    icon: Icons.location_on_outlined,
    keyboardType: TextInputType.streetAddress,
  ),
  text(icon: Icons.text_fields, keyboardType: TextInputType.multiline),
  authCode(icon: Icons.lock_clock_outlined, keyboardType: TextInputType.text),
  card(icon: Icons.phone, keyboardType: TextInputType.number),
  passKey(icon: Icons.lock_person_outlined, keyboardType: TextInputType.text),
  walletAddress(
    icon: Icons.account_balance_wallet_outlined,
    keyboardType: TextInputType.text,
  ),
  dateYM(icon: Icons.calendar_today, keyboardType: TextInputType.datetime),

  recoveryCodes(icon: Icons.security, keyboardType: TextInputType.multiline);

  final IconData icon;
  final TextInputType keyboardType;

  const FieldType({required this.icon, required this.keyboardType});

  bool get isPassword => this == password;
  bool get isAuthCode => this == authCode;
  bool get isCard => this == card;
  bool get isEmail => this == email;
  bool get isLink => this == website;
  bool get isIP => this == ipAddress;
  bool get isRecoveryCodes => this == recoveryCodes;

  bool get isLarge => switch (this) {
    FieldType.text => true,
    FieldType.passKey => true,
    _ => false,
  };

  bool get isImportant => switch (this) {
    FieldType.email => true,
    FieldType.username => true,
    FieldType.ipAddress => true,
    FieldType.walletAddress => true,
    _ => false,
  };

  bool get isTOTP => this == FieldType.authCode;

  bool get isSensitive => switch (this) {
    FieldType.password => true,
    FieldType.pin => true,
    FieldType.authCode => true,
    FieldType.passKey => true,
    _ => false,
  };

  bool get isImportantOrSensitive => isImportant || isSensitive;

  bool get isDate => switch (this) {
    FieldType.dateYMD => true,
    FieldType.dateYM => true,
    _ => false,
  };

  static List<FieldType> get getFields => [
    FieldType.email,
    FieldType.username,
    FieldType.password,
    FieldType.website,
    FieldType.number,
    FieldType.pin,
    FieldType.dateYMD,
    FieldType.ipAddress,
    FieldType.phone,
    FieldType.address,
    FieldType.text,
  ];
}
