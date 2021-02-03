import 'package:flutter/material.dart';
import 'package:loginProvider/providers/login_provider.dart';
import 'package:loginProvider/screens/home_page.dart';
import 'package:loginProvider/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          title: 'Login Test',
          theme: ThemeData(
            primaryColor: Colors.blueAccent[300],
          ),
          home: auth.isAuth
              ? HomePage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authSnapShot) =>
                      authSnapShot.connectionState == ConnectionState.waiting
                          ? Container(
                              child: Text("Loading Screen"),
                            )
                          : LoginPage(),
                ),
        ),
      ),
    );
  }
}
