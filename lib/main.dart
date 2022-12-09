import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/register_user.dart';
import 'package:firebase_flutter/login_user.dart';
import 'package:firebase_flutter/avatar_user.dart';
import 'package:firebase_flutter/text_user.dart';
import 'package:firebase_flutter/incident_register.dart';
import 'package:firebase_flutter/edit_user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,),
      initialRoute: "/"  ,
      routes: {
        "/" : (context) =>  RegisterScreen.only(),
        "login_user" : (context) => LoginScreen.only(),
        "edit_user" : (context) => EditUserScreen.only(),
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({ key, this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        child: Builder(
          builder: (BuildContext context){
              return LoginScreen(context);
          }
        )
      )

    );
  }
}*/
