import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/boton_verde.dart';

class Menu extends StatefulWidget {
  State<Menu> createState() => MenuState();
}

class MenuState extends State<Menu> {

  void irZona(){
    Navigator.pushNamed(context,"consult");
  }
  void irRegistro(){
    Navigator.pushNamed(context,"incident");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center
        (
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BottomGreen(
                50,
                MediaQuery.of(context).size.width * 0.4,
                "Consultar Zona",irZona
            ),
            BottomGreen(
                50,
                MediaQuery.of(context).size.width * 0.4,
                "Registrar Robo",irRegistro
            ),
          ],
        ),
      ) ,
      );
  }
}
