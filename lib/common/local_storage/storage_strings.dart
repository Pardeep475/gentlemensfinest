class StorageStrings {
  static final StorageStrings _storageStrings = StorageStrings._internal();

  factory StorageStrings() {
    return _storageStrings;
  }

  StorageStrings._internal();

  static const isLogin = "IS_LOGIN";
  static const setUpLanguage = "SETUP_LANGUAGE";

}