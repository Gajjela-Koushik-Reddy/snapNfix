import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView(
      {super.key, required this.onLogoutSuccess, required this.userCredential});
  final VoidCallback onLogoutSuccess;
  final GoogleSignInAccount userCredential;

  void handleLogout() {
    onLogoutSuccess();
  }

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  Future<void> _logOut() async {
    await GoogleSignIn().signOut();
    widget.onLogoutSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${widget.userCredential.displayName}"),
          Text(widget.userCredential.id),
          Text("${widget.userCredential.photoUrl}"),
          ElevatedButton(
              onPressed: () {
                _logOut();
              },
              child: const Text("Log Out")),
        ],
      ),
    ));
  }
}
