import 'package:flutter/material.dart';
import 'package:loginProvider/providers/login_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  void logout(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Container(
        child: RaisedButton(
          child: Text("Logout"),
          onPressed: () => logout(context),
        ),
      ),
    );
  }
}
