import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// ── Table ──────────────────────────────────────────────────────────────────
class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uid => text().unique()();
  TextColumn get username => text()();
  IntColumn get avatarIndex => integer()();
  TextColumn get currencyCode => text()();
  TextColumn get currencyName => text()();
  TextColumn get accType => text()();
  BoolColumn get pinEnabled => boolean().withDefault(const Constant(false))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// ── Database ───────────────────────────────────────────────────────────────
@DriftDatabase(tables: [UserProfiles])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Get profile (only one profile for offline mode)
  Future<UserProfile?> getProfile() =>
      (select(userProfiles)..limit(1)).getSingleOrNull();

  // Insert profile
  Future<int> insertProfile(UserProfilesCompanion profile) =>
      into(userProfiles).insert(profile);

  // Update profile
  Future<bool> updateProfile(UserProfilesCompanion profile) =>
      update(userProfiles).replace(profile);

  // Delete profile
  Future<int> deleteProfile() => delete(userProfiles).go();

  // Check if profile exists
  Future<bool> hasProfile() async {
    final profile = await getProfile();
    return profile != null;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'khatabook.db'));
    return NativeDatabase.createInBackground(file);
  });
}