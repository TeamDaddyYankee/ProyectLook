import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomGreen extends StatefulWidget {

  final String texto;
  double ancho=0;
  double alto=0;
  VoidCallback onPressed;

  BottomGreen(this.alto,this.ancho,this.texto,this.onPressed);


  State<BottomGreen> createState() => BottomGreenState();
}

class BottomGreenState extends State<BottomGreen> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: widget.ancho,
        height: widget.alto,
        alignment: Alignment.center,
        child: Text(
            widget.texto,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Colors.green,Colors.lightGreen
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight
          ),
          color: Color(0xff6B8B59)
        ),
      ),
    );
  }
}
