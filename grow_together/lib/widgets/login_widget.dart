import 'package:flutter/material.dart';

import '../user.dart';
import 'auth_widget.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.login, color: Colors.white),
      label: Text(UserSingleton().isLogged() ? "Logout" : "Login",
          style: TextStyle(color: Colors.white)),
      onPressed: () {
        UserSingleton().isLogged()
            ? _logout(context)
            : _showAuthModal(context, isLogin: true);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.green,
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showAuthModal(BuildContext context, {required bool isLogin}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isLogin ? 'Login' : 'Register'),
          content: AuthForm(isLogin: isLogin),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {


                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    UserSingleton().logout();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logged out'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
