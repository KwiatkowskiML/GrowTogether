import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../user.dart';

class AuthForm extends StatefulWidget {
  final VoidCallback onAuthSuccess;

  const AuthForm({
    Key? key,
    required this.onAuthSuccess,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isLogin = true; // Moved isLogin to state

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!EmailValidator.validate(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
          ),
          if (!_isLogin)
            TextFormField(
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _password) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onSaved: (value) {
                _confirmPassword = value!;
              },
            ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: ElevatedButton(
              child: Text(_isLogin ? 'Login' : 'Register'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  try {
                    if (_isLogin) {
                      await UserSingleton()
                          .login_user(email: _email, password: _password);
                    } else {
                      await UserSingleton()
                          .register_user(email: _email, password: _password);
                    }
                    widget.onAuthSuccess(); // Call the onAuthSuccess callback
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ),
          TextButton(
            child: Text(_isLogin
                ? 'Create an account'
                : 'Already have an account? Login'),
            onPressed: () {
              setState(() {
                _isLogin = !_isLogin;
              });
            },
          ),
        ],
      ),
    );
  }
}
