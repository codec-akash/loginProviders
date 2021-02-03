import 'package:flutter/material.dart';
import 'package:loginProvider/providers/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String email;
  String password;

  void submit() async {
    try {
      await Provider.of<Auth>(context, listen: false).login(email, password);
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                  print(email);
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'password'),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                  print(password);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
