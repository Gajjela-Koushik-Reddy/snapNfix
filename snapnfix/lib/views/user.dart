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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                height: 200,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  backgroundImage: widget.userCredential.photoUrl != null
                      ? NetworkImage(widget.userCredential.photoUrl.toString())
                      : const NetworkImage(
                          "https://as2.ftcdn.net/v2/jpg/02/15/84/43/1000_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg"),
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2)),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text("${widget.userCredential.displayName}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25)),
              )
            ],
          ),
          Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 75,
              child: ElevatedButton(
                onPressed: () {
                  _logOut();
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromRGBO(3, 58, 81, 1),
                    ),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                            color: Color.fromRGBO(193, 104, 62, 1),
                            width: 3)))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Log out", style: TextStyle(fontSize: 20)),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.logout_outlined,
                        size: 25,
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
