import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../domain/repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  final Rxn<User> rxUser = Rxn<User>();
  User? get user => rxUser.value;
  bool get isAuthenticated => rxUser.value != null;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Bind current user to the repository stream
    rxUser.bindStream(_authRepository.authStateChanges);
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    try {
      await _authRepository.signInWithEmailAndPassword(email, password);
      return true;
    } on FirebaseAuthException catch (e) {
      _showErrorSnackBar(e.message ?? 'Authentication failed');
      return false;
    } catch (e) {
      _showErrorSnackBar('An unexpected error occurred');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> register(String email, String password, String name) async {
    isLoading.value = true;
    try {
      await _authRepository.signUpWithEmailAndPassword(email, password, name);
      return true;
    } on FirebaseAuthException catch (e) {
      _showErrorSnackBar(e.message ?? 'Registration failed');
      return false;
    } catch (e) {
      _showErrorSnackBar('An unexpected error occurred');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await _authRepository.signOut();
    } catch (e) {
      _showErrorSnackBar('Failed to sign out');
    } finally {
      isLoading.value = false;
    }
  }

  void _showErrorSnackBar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFC13515), // AppColors.error
      colorText: const Color(0xFFFFFFFF), // AppColors.onError
      margin: const EdgeInsets.all(16.0),
      borderRadius: 8.0,
    );
  }
}
