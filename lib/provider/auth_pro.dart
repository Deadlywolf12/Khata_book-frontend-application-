import 'package:flutter/foundation.dart';
import 'package:khatabookn/utils/helper/secured_storage/secure_storage_helper.dart';
import 'package:khatabookn/utils/helper/secured_storage/secure_storage_keys.dart';


class AuthProvider extends ChangeNotifier {

  String _userMode = '';

  String get userMode => _userMode;

  Future<void> signUpUserAsGuest() async {
   await SecureStorageHelper.write(StorageKeys.appMode, 'guest');
    _userMode = 'guest';
    notifyListeners();
  }

  Future<void> loadUserMode() async {
    String? mode = await SecureStorageHelper.read(StorageKeys.appMode);
    _userMode = mode ?? '';
    notifyListeners();
  }
}