import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Databasehelper {
  static late Database database;

  static Future<void> initDatabase() async {
    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.linux || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    String dbPath = await _getDatabasePath('HabitTracker.db');

    database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE habits (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, start_date TEXT, streak INTEGER DEFAULT 0, lonest_streak INTEGER DEFAULT 0, is_active INTEGER DEFAULT 1)'
        );
        await db.execute(
          'CREATE TABLE habit_logs (id INTEGER PRIMARY KEY AUTOINCREMENT, habit_id INTEGER, date_completed TEXT, FOREIGN KEY (habit_id) REFERENCES habits (id) ON DELETE CASCADE)'
        );
      }
    );
  }

  static Future<String> _getDatabasePath(String dbName) async {
    if (kIsWeb) {
      return dbName;
    } else {
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      return join(documentDirectory.path, dbName);
    }
  }
}