import '../models/user.dart';
import 'storage_service.dart';

class AuthService {
  final StorageService _storageService = StorageService();

  // Register a new user
  Future<bool> register(User user) async {
    return await _storageService.saveUser(user);
  }

  // Login user
  Future<User?> login(String email, String password) async {
    final user = await _storageService.findUser(email, password);
    
    if (user != null) {
      // Save as current user
      await _storageService.saveCurrentUser(user);
    }
    
    return user;
  }

  // Get current logged-in user
  Future<User?> getCurrentUser() async {
    return await _storageService.getCurrentUser();
  }

  // Update user profile
  Future<bool> updateUserProfile(User updatedUser) async {
    final success = await _storageService.updateUser(updatedUser);
    
    if (success) {
      // Update current user in storage
      await _storageService.saveCurrentUser(updatedUser);
    }
    
    return success;
  }

  // Logout user
  Future<void> logout() async {
    await _storageService.clearCurrentUser();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }
}