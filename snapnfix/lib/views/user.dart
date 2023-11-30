import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key, required this.onLogoutSuccess});
  final VoidCallback onLogoutSuccess;

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
      body: ElevatedButton(
          onPressed: () {
            _logOut();
          },
          child: const Text("Log Out")),
    );
  }
}
