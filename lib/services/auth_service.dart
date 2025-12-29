import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';

class AuthService {
  static const String _fileName = 'users.json';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  Future<List<User>> _readUsers() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return [];
      }
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _writeUsers(List<User> users) async {
    final file = await _localFile;
    final jsonData = users.map((user) => user.toJson()).toList();
    await file.writeAsString(json.encode(jsonData));
  }

  Future<bool> register(User user) async {
    try {
      final users = await _readUsers();
      
      // Check if email already exists
      if (users.any((u) => u.email == user.email)) {
        return false;
      }

      users.add(user);
      await _writeUsers(users);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final users = await _readUsers();
      final user = users.firstWhere(
        (u) => u.email == email && u.password == password,
        orElse: () => throw Exception('User not found'),
      );
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> updateUser(User updatedUser) async {
    try {
      final users = await _readUsers();
      final index = users.indexWhere((u) => u.id == updatedUser.id);
      
      if (index != -1) {
        users[index] = updatedUser;
        await _writeUsers(users);
        return updatedUser;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}