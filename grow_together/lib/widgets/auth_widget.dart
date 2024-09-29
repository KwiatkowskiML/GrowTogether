import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart'; // Import email validator package

import '../user.dart';

class AuthForm extends StatefulWidget {
  final bool isLogin;

  const AuthForm({Key? key, required this.isLogin}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Email Field with Proper Validation
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
          // Password Field with Minimum Length Check
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
          // Confirm Password Field for Registration
          if (!widget.isLogin)
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
              child: Text(widget.isLogin ? 'Login' : 'Register'),
              onPressed: () async {
                // Validate the form before saving the data
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  try {
                    await UserSingleton()
                        .login_user(email: _email, password: _password);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          TextButton(
            child: Text(widget.isLogin
                ? 'Create an account'
                : 'Already have an account? Login'),
            onPressed: () {
              Navigator.of(context).pop();
              _showAuthModal(context, isLogin: !widget.isLogin);
            },
          ),
        ],
      ),
    );
  }

  // Modal for switching between login and register
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
}
