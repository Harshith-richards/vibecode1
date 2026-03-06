import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<UserCredential?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  Future<void> syncTaskProgress({
    required String taskId,
    required bool completed,
  }) async {
    final user = currentUser;
    if (user == null) return;
    await _db.collection('users').doc(user.uid).collection('progress').doc(taskId).set({
      'taskId': taskId,
      'completed': completed,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<Map<String, bool>> downloadTaskProgress() async {
    final user = currentUser;
    if (user == null) return {};
    final query =
        await _db.collection('users').doc(user.uid).collection('progress').get();
    return {
      for (final doc in query.docs) doc.id: (doc.data()['completed'] as bool? ?? false),
    };
  }
}
