// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';

class StorageService {
  static const String _fileName = 'db.json';

  // Get the path to the JSON file
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  // Read data from JSON file
  Future<Map<String, dynamic>> readData() async {
    try {
      final file = await _localFile;
      
      // Check if file exists
      if (!await file.exists()) {
        // Create initial structure
        final initialData = {
          'users': [],
          'currentUser': null,
        };
        await writeData(initialData);
        return initialData;
      }

      // Read file content
      final contents = await file.readAsString();
      return json.decode(contents) as Map<String, dynamic>;
    } catch (e) {
      print('Error reading data: $e');
      return {
        'users': [],
        'currentUser': null,
      };
    }
  }

  // Write data to JSON file
  Future<void> writeData(Map<String, dynamic> data) async {
    try {
      final file = await _localFile;
      final jsonString = json.encode(data);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error writing data: $e');
    }
  }

  // Save a new user to the database
  Future<bool> saveUser(User user) async {
    try {
      final data = await readData();
      final users = List<Map<String, dynamic>>.from(data['users'] ?? []);

      // Check if email already exists
      final emailExists = users.any((u) => u['email'] == user.email);
      if (emailExists) {
        return false;
      }

      // Add new user
      users.add(user.toJson());
      data['users'] = users;
      
      await writeData(data);
      return true;
    } catch (e) {
      print('Error saving user: $e');
      return false;
    }
  }

  // Find user by email and password
  Future<User?> findUser(String email, String password) async {
    try {
      final data = await readData();
      final users = List<Map<String, dynamic>>.from(data['users'] ?? []);

      final userMap = users.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
        orElse: () => {},
      );

      if (userMap.isEmpty) {
        return null;
      }

      return User.fromJson(userMap);
    } catch (e) {
      print('Error finding user: $e');
      return null;
    }
  }

  // Save current logged-in user
  Future<void> saveCurrentUser(User user) async {
    try {
      final data = await readData();
      data['currentUser'] = user.toJson();
      await writeData(data);
    } catch (e) {
      print('Error saving current user: $e');
    }
  }

  // Get current logged-in user
  Future<User?> getCurrentUser() async {
    try {
      final data = await readData();
      final currentUserMap = data['currentUser'];
      
      if (currentUserMap == null) {
        return null;
      }

      return User.fromJson(currentUserMap as Map<String, dynamic>);
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  // Update user profile
  Future<bool> updateUser(User updatedUser) async {
    try {
      final data = await readData();
      final users = List<Map<String, dynamic>>.from(data['users'] ?? []);

      // Find and update the user
      final userIndex = users.indexWhere((u) => u['id'] == updatedUser.id);
      
      if (userIndex == -1) {
        return false;
      }

      users[userIndex] = updatedUser.toJson();
      data['users'] = users;

      // Update current user if it's the same user
      if (data['currentUser'] != null && 
          data['currentUser']['id'] == updatedUser.id) {
        data['currentUser'] = updatedUser.toJson();
      }

      await writeData(data);
      return true;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  // Clear current user (logout)
  Future<void> clearCurrentUser() async {
    try {
      final data = await readData();
      data['currentUser'] = null;
      await writeData(data);
    } catch (e) {
      print('Error clearing current user: $e');
    }
  }

  // Get all users (for debugging)
  Future<List<User>> getAllUsers() async {
    try {
      final data = await readData();
      final users = List<Map<String, dynamic>>.from(data['users'] ?? []);
      return users.map((userMap) => User.fromJson(userMap)).toList();
    } catch (e) {
      // ignore: duplicate_ignore
      // ignore: avoid_print
      print('Error getting all users: $e');
      return [];
    }
  }
}