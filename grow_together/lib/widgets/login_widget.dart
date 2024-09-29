import 'package:flutter/material.dart';

import '../user.dart';
import 'auth_widget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool isLogged = UserSingleton().isLogged();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(isLogged ? Icons.logout : Icons.login, color: Colors.white),
      label: Text(isLogged ? "Logout" : "Login",
          style: TextStyle(color: Colors.white)),
      onPressed: () {
        isLogged ? _logout(context) : _showAuthModal(context, isLogin: true);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.green,
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _showAuthModal(BuildContext context, {required bool isLogin}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isLogin ? 'Login' : 'Register'),
          content: AuthForm(
            isLogin: isLogin,
            onAuthSuccess: () {
              setState(() {
                isLogged = true;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Correctly Logged in'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
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
    setState(() {
      isLogged = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logged out'),
        backgroundColor: Colors.green,
      ),
    );
  }
}