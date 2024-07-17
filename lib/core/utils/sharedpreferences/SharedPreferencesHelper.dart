import 'SharedPreferencesProvider.dart';

class AppSharedPreferences {
  //todo move these to constants


  static const keyDeviceId = "PREF_KEY_DEVICE_ID";
  static const keyFirstTime = "PREF_KEY_FIRST_TIME";
  static const keyLanguage = "PREF_KEY_LANGUAGE";
  static const keyUserPhoneNumber = "PREF_KEY_USER_PHONE_NUMBER";
  static const keyUserEmailAddress = "PREF_KEY_USER_EMAIL_ADDRESS";
  static const keyPersonId = "PREF_KEY_PERSON_ID";
  static const keyEnv = "PREF_KEY_ENV";
  static const keyUserName = "PREF_KEY_NAME";
  static const keyUserAccountName = "PREF_KEY_USER_ACCOUNT_NAME";
  static const keyUserType = "PREF_KEY_USER_TYPE";
  static const keyUserInterests = "PREF_KEY_INTERESTS";
  static const bankAccount = "PREF_KEY_BANK";

  static const keyIsPhoneVerified = "PREF_KEY_VERIFICATION_PHONE";
  static const keyIsEmailVerified = "PREF_KEY_VERIFICATION_EMAIL";
  static const isStableChose = "PREF_KEY_CHOSE_STABLE";

  static const themeMode = "PREF_KEY_THEME_MODE";

  static bool? initialized;
  static SharedPreferencesProvider? _pref;

  static init() async {
    _pref = await SharedPreferencesProvider.getInstance();
  }

  static clear() {
    _pref?.clear();
  }

  static clearForLogOut() {
    removePhoneNumber();
    removeEmailAddress();
    removePhoneVerified();
    removeTypeSelected();
  }

  ///  Store User Phone Number
  static String get userPhoneNumber => _pref?.read(keyUserPhoneNumber) ?? '';

  static set inputPhoneNumber(String phoneNumber) =>
      _pref?.save(keyUserPhoneNumber, phoneNumber);

  static bool get hasPhoneNumber => _pref?.contains(keyUserPhoneNumber);

  static removePhoneNumber() => _pref?.remove(keyUserPhoneNumber);

  ///  Store Name
  static String get getName => _pref?.read(keyUserName) ?? '';

  static set inputName(String name) =>
      _pref?.save(keyUserName, name);

  static bool get hasName => _pref?.contains(keyUserName);

  static removeName() => _pref?.remove(keyUserName);
  ///  Store person id
  static String get personId => _pref?.read(keyPersonId) ?? '';

  static set setPersonId(String personId) =>
      _pref?.save(keyPersonId, personId);

  static bool get hasPersonId => _pref?.contains(keyPersonId);

  static removePersonId() => _pref?.remove(keyPersonId);

  ///  Store User Email Address
  static String get userEmailAddress => _pref?.read(keyUserEmailAddress) ?? '';

  static set inputEmailAddress(String email) =>
      _pref?.save(keyUserEmailAddress, email);

  static bool get hasEmailAddress => _pref?.contains(keyUserEmailAddress);

  static removeEmailAddress() => _pref?.remove(keyUserEmailAddress);

  ///  Store User device id
  static String get getDeviceId => _pref?.read(keyDeviceId) ?? '';

  static set setDeviceId(String deviceId) => _pref?.save(keyDeviceId, deviceId);

  static bool get hasDeviceId => _pref?.contains(keyDeviceId);

  static removeDeviceId() => _pref?.remove(keyDeviceId);

  ///  Store User Theme
  static String get getTheme => _pref?.read(themeMode) ?? 'ThemeCubitMode.light';

  static set setTheme(String theme) => _pref?.save(themeMode, theme);

  ///  Store the env
  static String get getEnvType => _pref?.read(keyEnv) ?? 'https://pet-webapi-uaeno-prod-001.azurewebsites.net';

  static set setEnvType(String env) => _pref?.save(keyEnv, env);

  ///Language
  static String get lang {
    String? lang = _pref?.read(keyLanguage);
    if (lang == null || lang.isEmpty) {
      return 'en';
    } else {
      return lang;
    }
  }

  static set lang(String lang) => _pref?.save(keyLanguage, lang);

  ///FIRST_TIME Starting Application
  static bool? get getFirstTime {
    if (_pref?.readBoolean(keyFirstTime) == null) firstTime = true;

    return _pref?.readBoolean(keyFirstTime) ?? true;
  }

  static set firstTime(bool? first) =>
      _pref?.saveBoolean(keyFirstTime, first) ?? true;

  ///IS THERE BANK ACCOUNT
  static bool? get getBankAccount {
    if (_pref?.readBoolean(bankAccount) == null) setBankAccount = true;

    return _pref?.readBoolean(bankAccount) ?? true;
  }

  static set setBankAccount(bool? first) =>
      _pref?.saveBoolean(bankAccount, first) ?? true;


  /// is phone number verified
  static bool? get getPhoneVerified {
    if (_pref?.readBoolean(keyIsPhoneVerified) == null) phoneVerified = false;

    return _pref?.readBoolean(keyIsPhoneVerified) ?? false;
  }

  static set phoneVerified(bool? verified) =>
      _pref?.saveBoolean(keyIsPhoneVerified, verified) ?? false;

  static removePhoneVerified() => _pref?.remove(keyIsPhoneVerified);

  /// is has userName
  static bool? get isHasUserName {
    if (_pref?.readBoolean(keyUserAccountName) == null) hasUserAccountName = false;

    return _pref?.readBoolean(keyUserAccountName) ?? false;
  }

  static set hasUserAccountName(bool? verified) =>
      _pref?.saveBoolean(keyUserAccountName, verified) ?? false;

  static removeUserAccountName() => _pref?.remove(keyUserAccountName);



  /// is email number verified
  static bool? get getEmailVerified {
    if (_pref?.readBoolean(keyIsEmailVerified) == null) emailVerified = false;

    return _pref?.readBoolean(keyIsEmailVerified) ?? false;
  }

  static set emailVerified(bool? verified) =>
      _pref?.saveBoolean(keyIsEmailVerified, verified) ?? false;


  /// is chose stable
  static bool? get isStableChosen {
    if (_pref?.readBoolean(isStableChose) == null) choseStable = false;

    return _pref?.readBoolean(isStableChose) ?? false;
  }

  static set choseStable(bool? verified) =>
      _pref?.saveBoolean(isStableChose, verified) ?? false;

  /// is user type selected
  static bool? get getIsITypeSelected {
    if (_pref?.readBoolean(keyUserType) == null) typeSelected = false;

    return _pref?.readBoolean(keyUserType) ?? false;
  }

  static removeTypeSelected() => _pref?.remove(keyUserType);

  static set typeSelected(bool? type) =>
      _pref?.saveBoolean(keyUserType, type) ?? false;

  static const String _keyData = 'myData';
  static const String _keyExpiration = 'expirationTime';

  // Function to save data with an expiration date to SharedPreferences
  static Future<bool> saveDataWithExpiration(String data, Duration expirationDuration) async {
    try {
      DateTime expirationTime = DateTime.now().add(expirationDuration);
      await _pref?.save(_keyData, data);
      await _pref?.save(_keyExpiration, expirationTime.toIso8601String());
      print('Data saved to SharedPreferences.');
      return true;
    } catch (e) {
      print('Error saving data to SharedPreferences: $e');
      return false;
    }
  }

  // Function to get data from SharedPreferences if it's not expired
  static Future<String?> getDataIfNotExpired() async {
    try {
      String? data = _pref?.read(_keyData);
      String? expirationTimeStr = _pref?.read(_keyExpiration);
      if (data == null || expirationTimeStr == null) {
        print('No data or expiration time found in SharedPreferences.');
        return null; // No data or expiration time found.
      }

      DateTime expirationTime = DateTime.parse(expirationTimeStr);
      if (expirationTime.isAfter(DateTime.now())) {
        print('Data has not expired.');
        // The data has not expired.
        return data;
      } else {
        // Data has expired. Remove it from SharedPreferences.
        await _pref?.remove(_keyData);
        await _pref?.remove(_keyExpiration);
        print('Data has expired. Removed from SharedPreferences.');
        return null;
      }
    } catch (e) {
      print('Error retrieving data from SharedPreferences: $e');
      return null;
    }
  }

  // Function to clear data from SharedPreferences
  static Future<void> clearData() async {
    try {
      await _pref?.remove(_keyData);
      await _pref?.remove(_keyExpiration);
      print('Data cleared from SharedPreferences.');
    } catch (e) {
      print('Error clearing data from SharedPreferences: $e');
    }
  }
}
