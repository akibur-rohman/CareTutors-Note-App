import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<UserCredential> signInWithEmailAndPassword(String email, String password);
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password, String name);
  Future<void> signOut();
}
