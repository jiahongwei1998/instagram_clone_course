import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone_course/state/auth/constants/constants.dart';
import 'package:instagram_clone_course/state/auth/models/auth_result.dart';
import 'package:instagram_clone_course/state/posts/typedefs/user_id.dart';

class Authenticator {
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get dislayName => FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Constatns.emailScope,
      ],
    );

    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGithub(BuildContext context) async {
    final gitHubSignIn = GitHubSignIn(
      clientId: '3ab49e4175213dfcde09',
      clientSecret: '2ba7f4a07073fc087ebdae06ce69617317f58f55',
      redirectUrl:
          'https://instagram-clone-course-jhw.firebaseapp.com/__/auth/handler',
      title: 'GitHub Connection',
      centerTitle: false,
    );
    final result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        return AuthResult.success;
      case GitHubSignInResultStatus.cancelled:
        return AuthResult.aborted;
      case GitHubSignInResultStatus.failed:
        return AuthResult.failure;
    }
  }
}
