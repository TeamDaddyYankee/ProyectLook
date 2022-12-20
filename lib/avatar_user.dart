import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/boton_verde.dart';

class AvatarUser extends StatefulWidget {

  State<AvatarUser> createState() => AvatarUserState();
}

class AvatarUserState extends State<AvatarUser> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Color(0xff6B8B59),
        foregroundColor: Colors.white,
        backgroundImage: AssetImage("assets/user_avatar.png"),
      ),
    );
  }

}