import 'package:flutter/material.dart';
import 'User.dart';
import 'InputValidator.dart';
import 'dbhelper.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          //当leading部件为空时，放置一个默认样式的leading
          automaticallyImplyLeading: true,
        ),
        body: Builder(
          builder: (BuildContext context) => SafeArea(
                  child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: InputValidator.inputUsernameValidate,
                      controller: usernameTextEditingController,
                      decoration: InputDecoration(
                        labelText: 'Your user name.',
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: passwordTextEditingController,
                      validator: InputValidator.inputPasswordValidate,
                      decoration: InputDecoration(
                        labelText: 'Your password',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: confirmPasswordTextEditingController,
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter password';
                        if (confirmPasswordTextEditingController.text !=
                            passwordTextEditingController.text)
                          return 'Two passwords are inconsistent';
                      },
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    RaisedButton(
                      child: Text('Sign Up'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          var user = User(usernameTextEditingController.text,
                              passwordTextEditingController.text);
                          dbHelper.saveUser(user);
                          Navigator.pop(
                              context, usernameTextEditingController.text);
                        }
                      },
                    )
                  ],
                ),
              )),
        ));
  }
}
