import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:khatabookn/utils/helper/secured_storage/secure_storage_helper.dart';
import 'package:khatabookn/utils/helper/secured_storage/secure_storage_keys.dart';
import 'package:uuid/uuid.dart';

enum AppMode { none, guest, online }

class AuthProvider extends ChangeNotifier {
  AppMode _appMode = AppMode.none;
  bool _isLoading = false;
  bool _isAuthenticated = false;

  int _attempts = 0;
  bool _isLocked = false;
  DateTime? _lockUntil;
  Timer? _lockTimer;           // ← countdown timer
  int _remainingSeconds = 0;   // ← seconds left shown in UI

  DateTime? get lockUntil => _lockUntil;
  int get attempts => _attempts;
  bool get isLocked => _isLocked;
  int get remainingSeconds => _remainingSeconds; // ← exposed to UI

  static const int maxAttempts = 3;
  static const Duration lockDuration = Duration(minutes: 1);

  AppMode get appMode => _appMode;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  bool get isGuest => _appMode == AppMode.guest;
  bool get isOnline => _appMode == AppMode.online;
  bool get hasMode => _appMode != AppMode.none;

  // ── Loading helper ───────────────────────────────────────────────────────
  Future<T> _runWithLoading<T>(Future<T> Function() task) async {
    _setLoading(true);
    try {
      return await task();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }

  void _updateState({AppMode? appMode, bool? isAuthenticated}) {
    bool shouldNotify = false;

    if (appMode != null && appMode != _appMode) {
      _appMode = appMode;
      shouldNotify = true;
    }
    if (isAuthenticated != null && isAuthenticated != _isAuthenticated) {
      _isAuthenticated = isAuthenticated;
      shouldNotify = true;
    }

    if (shouldNotify) notifyListeners();
  }

  // ── App mode ─────────────────────────────────────────────────────────────
  Future<void> signUpUserAsGuest() async {
    await SecureStorageHelper.write(StorageKeys.appMode, 'guest');
    _updateState(appMode: AppMode.guest);
    log('user signed up as guest');
  }

  Future<void> signUpUserAsOnline() async {
    await SecureStorageHelper.write(StorageKeys.appMode, 'online');
    _updateState(appMode: AppMode.online);
  }

  Future<void> loadUserMode() async {
    final mode = await SecureStorageHelper.read(StorageKeys.appMode);
    final parsedMode = switch (mode) {
      'guest' => AppMode.guest,
      'online' => AppMode.online,
      _ => AppMode.none,
    };
    _updateState(appMode: parsedMode);
  }

  // ── PIN ──────────────────────────────────────────────────────────────────
  Future<void> saveOfflinePin(String pin) {
    return _runWithLoading(() async {
      final salt = const Uuid().v4();
      await SecureStorageHelper.write(StorageKeys.pinSalt, salt);
      final hashedPin = _hashPin(pin, salt);
      await SecureStorageHelper.write(StorageKeys.savePin, hashedPin);
      await SecureStorageHelper.write(StorageKeys.pinCreated, 'true');
      log('pin save success');
    });
  }

  Future<bool> authenticatePin(String pin) {
    return _runWithLoading(() async {
      if (_isLocked) {
        if (_lockUntil != null && DateTime.now().isBefore(_lockUntil!)) {
          return false;
        } else {
          // Lock expired
          _isLocked = false;
          _attempts = 0;
          _lockTimer?.cancel();
          _remainingSeconds = 0;
          await _clearLockState();
        }
      }

      final salt = await SecureStorageHelper.read(StorageKeys.pinSalt);
      final storedHash = await SecureStorageHelper.read(StorageKeys.savePin);

      if (salt == null || storedHash == null) return false;

      final inputHash = _hashPin(pin, salt);
      final isValid = inputHash == storedHash;

      if (isValid) {
        _attempts = 0;
        _lockTimer?.cancel();
        _remainingSeconds = 0;
        await _clearLockState();
        _updateState(isAuthenticated: true);
        return true;
      }

      _attempts++;
      await SecureStorageHelper.write(
        StorageKeys.failedAttempts,
        _attempts.toString(),
      );

      if (_attempts >= maxAttempts) {
        _lockApp();
      }

      return false;
    });
  }

  // ── Lock ─────────────────────────────────────────────────────────────────
  void _lockApp() {
    _isLocked = true;
    _lockUntil = DateTime.now().add(lockDuration);
    _updateState(isAuthenticated: false);
    _persistLockState();
    _startCountdown();
    notifyListeners();
  }

  // ── Countdown timer ───────────────────────────────────────────────────────
  void _startCountdown() {
    _lockTimer?.cancel();

    if (_lockUntil == null) return;

    _remainingSeconds = _lockUntil!.difference(DateTime.now()).inSeconds;
    if (_remainingSeconds <= 0) {
      _unlockApp();
      return;
    }

    _lockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_lockUntil == null) {
        timer.cancel();
        return;
      }

      final remaining = _lockUntil!.difference(DateTime.now()).inSeconds;

      if (remaining <= 0) {
        timer.cancel();
        _unlockApp();
      } else {
        _remainingSeconds = remaining;
        notifyListeners(); // ← rebuilds UI every second
      }
    });
  }

  void _unlockApp() {
    _isLocked = false;
    _attempts = 0;
    _lockUntil = null;
    _remainingSeconds = 0;
    _lockTimer?.cancel();
    _clearLockState();
    notifyListeners();
  }

  void checkLockStatus() {
    if (_isLocked && _lockUntil != null) {
      if (DateTime.now().isAfter(_lockUntil!)) {
        _unlockApp();
      }
    }
  }

  // ── Persist lock state ────────────────────────────────────────────────────
  Future<void> _persistLockState() async {
    await SecureStorageHelper.write(StorageKeys.isLocked, 'true');
    await SecureStorageHelper.write(
      StorageKeys.lockUntil,
      _lockUntil!.toIso8601String(),
    );
    await SecureStorageHelper.write(
      StorageKeys.failedAttempts,
      _attempts.toString(),
    );
  }

  Future<void> _clearLockState() async {
    await SecureStorageHelper.delete(StorageKeys.isLocked);
    await SecureStorageHelper.delete(StorageKeys.lockUntil);
    await SecureStorageHelper.delete(StorageKeys.failedAttempts);
  }

  // ── Restore lock state on app start ──────────────────────────────────────
  Future<void> restoreLockState() async {
    final isLockedStr = await SecureStorageHelper.read(StorageKeys.isLocked);
    final lockUntilStr = await SecureStorageHelper.read(StorageKeys.lockUntil);
    final attemptsStr = await SecureStorageHelper.read(StorageKeys.failedAttempts);

    if (isLockedStr == 'true' && lockUntilStr != null) {
      final lockUntil = DateTime.parse(lockUntilStr);

      if (DateTime.now().isBefore(lockUntil)) {
        // Still locked — restore and start countdown
        _isLocked = true;
        _lockUntil = lockUntil;
        _attempts = int.tryParse(attemptsStr ?? '0') ?? 0;
        _startCountdown(); // ← auto unlocks when timer hits 0
        notifyListeners();
      } else {
        // Lock already expired while app was closed
        await _clearLockState();
      }
    }
  }

  // ── Background handling ───────────────────────────────────────────────────
  void logoutOnBackground() async {
    await SecureStorageHelper.write(
      StorageKeys.lastActiveTime,
      DateTime.now().toIso8601String(),
    );
  }

  Future<void> checkBackgroundLock() async {
    final lastTimeStr =
        await SecureStorageHelper.read(StorageKeys.lastActiveTime);

    if (lastTimeStr == null) return;

    final lastTime = DateTime.parse(lastTimeStr);
    final now = DateTime.now();
    final difference = now.difference(lastTime);

    if (difference.inMinutes >= 15) {
      _isAuthenticated = false;
      _isLocked = true;
      _lockUntil = now.add(const Duration(minutes: 1));
      await _persistLockState();
      _startCountdown();
      notifyListeners();
    }
  }

  // ── Clear all ─────────────────────────────────────────────────────────────
  Future<void> clearMode() async {
    _lockTimer?.cancel();
    await SecureStorageHelper.delete(StorageKeys.appMode);
    await SecureStorageHelper.delete(StorageKeys.savePin);
    await SecureStorageHelper.delete(StorageKeys.pinSalt);
    await _clearLockState();
    _updateState(appMode: AppMode.none, isAuthenticated: false);
  }

  @override
  void dispose() {
    _lockTimer?.cancel();
    super.dispose();
  }

  // ── Hashing ───────────────────────────────────────────────────────────────
  String _hashPin(String pin, String salt) {
    return sha256.convert(utf8.encode(pin + salt)).toString();
  }
}