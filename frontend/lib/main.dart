import 'package:flutter/material.dart';
import 'package:frontend/pages/LoginPage.dart';
import 'package:frontend/pages/RegisterPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
     routes:{
       '/': ( context ) => const LoginPage(),
        '/register': ( context ) => const RegisterPage() 
        },
    );
  }
}



