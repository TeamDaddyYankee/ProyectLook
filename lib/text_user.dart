import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/boton_verde.dart';


class TextUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Hola USUARIO 1 ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white
        ),

      ),
    );
  }

}