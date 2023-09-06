import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.lightBlue.withOpacity(0.9),
                      Colors.deepPurple.withOpacity(0.9)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 0.7])),
          ),
          SingleChildScrollView(
            child: Container(
              height: devicesize.height,
              width: devicesize.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 94),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-5.00),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.brown,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.black,
                                offset: Offset(1, 1))
                          ]),
                      child: Text(
                        'My Shop',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
                    Flexible(
                        flex: devicesize.width > 600 ? 2 : 1, child: AuthCard())
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {'email': '', 'password': ''};
  // ignore: unused_field
  var _isloading = false;
  final _passwordController = TextEditingController();
  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('An error occurred!'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Okay'))
          ],
        );
      },
    );
  }

  void _submit() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _formkey.currentState!.save();
    setState(() {
      _isloading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<auth>(context, listen: false)
            .login(_authData['email']!, _authData['password']!);
      } else {
        await Provider.of<auth>(context, listen: false)
            .signup(_authData['email']!, _authData['password']!);
      }
    } catch (error) {
      var errorMessage = 'Could not authenticate please try later';
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find any user with that Email';
      }
      if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Incorrect password';
      }
      if (error.toString().contains('USER_DISABLED')) {
        errorMessage = 'User is disabled';
      }
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This Email is already in use';
      }
      if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Incorrect Email';
      }
      _showDialog(errorMessage);
    }

    setState(() {
      _isloading = false;
    });
  }

  void _switchauthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8,
      child: Container(
        height: _authMode == AuthMode.Signup ? 340 : 290,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 340 : 290,
        ),
        width: devicesize.width * 0.75,
        padding: EdgeInsets.all(18),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid Email';
                    }
                    ;
                  },
                  onSaved: (newValue) {
                    _authData['email'] = newValue!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Invalid Email';
                    }
                    ;
                  },
                  onSaved: (newValue) {
                    _authData['password'] = newValue!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Password doesn\'t match';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isloading)
                  CircularProgressIndicator()
                else
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).primaryColor),
                    child: TextButton(
                      onPressed: () {
                        _submit();
                        FocusScope.of(context).unfocus();
                      },
                      child: Text(
                        _authMode == AuthMode.Login ? 'Log-In' : 'Sign-In',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: _switchauthMode,
                  child: Text(
                      (_authMode == AuthMode.Login ? 'Sign-In' : 'LogIn') +
                          '  Instead'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
