enum SharedPreferencesKeys {
  token,
  email,
  firstName,
  lastName,
  mosqueId,
  experiences,
  codeUser,
  userId,
  image,
  userName,
  currency,
  phoneNumber,
  gender,
}

extension LocaleKeysExtension on SharedPreferencesKeys {
  String get value {
    switch (this) {
      case SharedPreferencesKeys.currency:
        return 'currency';
      case SharedPreferencesKeys.token:
        return 'token';
      // Note: This seems incorrect, should it be 'lang'?
      case SharedPreferencesKeys.userId:
        return 'user_id';
      case SharedPreferencesKeys.image:
        return 'image';
      case SharedPreferencesKeys.lastName:
        return 'last_name';
      case SharedPreferencesKeys.codeUser:
        return 'code_user';
      case SharedPreferencesKeys.mosqueId:
        return 'mosque_id';
      case SharedPreferencesKeys.email:
        return 'email';
      case SharedPreferencesKeys.experiences:
        return 'experiences';
      case SharedPreferencesKeys.phoneNumber:
        return 'phone_number';
      case SharedPreferencesKeys.gender:
        return 'gender';
      case SharedPreferencesKeys.firstName:
        return 'first_name'; // Added missing case
      case SharedPreferencesKeys.userName:
        return 'user_name'; // Added missing case
      default:
        throw Exception('Unknown LocaleKey');
    }
  }
}