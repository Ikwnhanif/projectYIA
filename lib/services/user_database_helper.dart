import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:tenantyia/models/akun.dart';
import 'package:tenantyia/services/dbhelper.dart';

class UserDatabaseHelper {
  static String tableName = 'User';

  static Future<void> createUser(Akun user) async {
    final db = await DatabaseHelper.instance.database;
    var username = user.username;
    var key = utf8.encode(user.password.toString());
    var digest = sha1.convert(key);
    user.password = digest.toString();

    List<Map> list = await db!
        .query('$tableName', where: 'username = ?', whereArgs: [username]);

    if (list.isEmpty) {
      await db.insert(tableName, user.toMap());
    } else {
      throw Exception('Username already exists');
    }
  }

  static Future<List<Akun>> getUsers() async {
    final db = await DatabaseHelper.instance.database;
    List<Map> list = await db!.query('$tableName');

    List<Akun> users = [];

    for (var item in list) {
      var user = Akun.fromMap(item);
      users.add(user);
    }
    print(users);

    return users;
  }

  static Future<List<Akun>> getUserByUsernameAndPassword(
      String username, String password) async {
    final db = await DatabaseHelper.instance.database;
    List<Map> list = await db!
        .query('$tableName', where: 'username = ?', whereArgs: [username]);

    List<Akun> users = [];

    if (list.isEmpty) {
      throw Exception('Username or password is incorrect');
    }

    var key = utf8.encode(password);
    var digest = sha1.convert(key);

    if (list[0]['password'] != digest.toString()) {
      throw Exception('Username or password is incorrect');
    }

    for (var item in list) {
      var user = Akun.fromMap(item);
      users.add(user);
    }
    return users;
  }

  static Future<void> updateUser(Akun user) async {
    final db = await DatabaseHelper.instance.database;
    await db!
        .update(tableName, user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<void> deleteUser(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
