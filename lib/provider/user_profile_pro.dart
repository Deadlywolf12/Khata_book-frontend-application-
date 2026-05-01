import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import 'package:khatabookn/database/app_database.dart';
import 'package:uuid/uuid.dart';
import 'package:khatabookn/models/currency_models.dart';

enum ProfileStatus { initial, loading, loaded, error }

class UserProfileProvider extends ChangeNotifier {
  final AppDatabase _db;

  UserProfileProvider(this._db);

  ProfileStatus _status = ProfileStatus.initial;
  UserProfile? _profile;
  String? _error;

  ProfileStatus get status => _status;
  UserProfile? get profile => _profile;
  String? get error => _error;
  bool get hasProfile => _profile != null;
  bool get isLoading => _status == ProfileStatus.loading;

  // ── Load profile from DB ─────────────────────────────────────────────────
  Future<void> loadProfile() async {
    try {
      _status = ProfileStatus.loading;
      notifyListeners();

      _profile = await _db.getProfile();
      log("accType: ${_profile?.accType} , and currencyCode: ${_profile?.currencyCode} and currencyName: ${_profile?.currencyName} and pinEnabled: ${_profile?.pinEnabled} , and uid: ${_profile?.uid} and updatedAt: ${_profile?.updatedAt}, and createdAt: ${_profile?.createdAt} , and id: ${_profile?.id} and avatarIndex: ${_profile?.avatarIndex} and username: ${_profile?.username} , and currencyCode: ${_profile?.currencyCode} and currencyName: ${_profile?.currencyName}");
      _status = ProfileStatus.loaded;
    } catch (e) {
      _error = e.toString();
      _status = ProfileStatus.error;
    }
    notifyListeners();
  }

  // ── Create offline profile ───────────────────────────────────────────────
  Future<bool> createProfile({
    required String username,
    required int avatarIndex,
    required Currency currency,
    required String accType,
    required bool pinEnabled,
   
  }) async {
    try {
      _status = ProfileStatus.loading;
      notifyListeners();
   var uuid = Uuid();


      await _db.insertProfile(
        UserProfilesCompanion(
          username: Value(username),
          avatarIndex: Value(avatarIndex),
          currencyCode: Value(currency.code),
          currencyName: Value(currency.subtitle),
          accType: Value(accType),
          pinEnabled: Value(pinEnabled),
          uid:Value(uuid.v4()),
        ),
      );

      _profile = await _db.getProfile();
      _status = ProfileStatus.loaded;
      notifyListeners();
      log( "Profile created: ${_profile!.username}, Avatar: ${_profile!.avatarIndex}, Currency: ${_profile!.currencyCode}, AccType: ${_profile!.accType}, PinEnabled: ${_profile!.pinEnabled}");
      return true;
    } catch (e) {
      _error = e.toString();
      _status = ProfileStatus.error;
      log(  "Error creating profile: $_error");
      notifyListeners();
      return false;
    }
  }

  // ── Update profile ───────────────────────────────────────────────────────
  Future<bool> updateProfile({
    String? username,
    int? avatarIndex,
    Currency? currency,
    bool? pinEnabled,
    
  }) async {
    if (_profile == null) return false;

    try {
      await _db.updateProfile(
        UserProfilesCompanion(
          id: Value(_profile!.id),
          username: Value(username ?? _profile!.username),
          avatarIndex: Value(avatarIndex ?? _profile!.avatarIndex),
          currencyCode: Value(currency?.code ?? _profile!.currencyCode),
          currencyName: Value(currency?.subtitle ?? _profile!.currencyName),
          accType: Value(_profile!.accType),
          pinEnabled: Value(pinEnabled ?? _profile!.pinEnabled),
         updatedAt: Value(DateTime.now()),
         
        ),
      );

      _profile = await _db.getProfile();
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // ── Delete profile (reset app) ───────────────────────────────────────────
  Future<void> deleteProfile() async {
    await _db.deleteProfile();
    _profile = null;
    _status = ProfileStatus.initial;
    notifyListeners();
  }
}