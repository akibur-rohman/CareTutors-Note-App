import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repository/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    // Update the display name
    await userCredential.user?.updateDisplayName(name.trim());
    await userCredential.user?.reload();
    return userCredential;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
