import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/boton_verde.dart';

class EditUserScreen extends StatefulWidget {
  BuildContext contexto;
  State<EditUserScreen> createState() => EditUserScreenState();
  EditUserScreen(this.contexto);
}

class EditUserScreenState extends State<EditUserScreen> {

  TextEditingController usuario=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController movil=TextEditingController();

  TextEditingController contra=TextEditingController();
  TextEditingController contra_actual=TextEditingController();
  bool contra_invisible = false;

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    usuario.dispose();
    email.dispose();
    movil.dispose();
    contra.dispose();
    contra_actual.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
        return SingleChildScrollView(
          child:Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.black,
                    height: MediaQuery.of(widget.contexto).size.height *0.25,
                  )
                ],
              ),
              Form(
                    child: Container(
                      width: MediaQuery.of(widget.contexto).size.width*0.9,
                        alignment: Alignment.center,
                        child:Column(
                        children: [
                          subtitle("Informacion de Usuario"),
                          informacion_user(),
                          espacio_vertical(10),
                          BottomGreen(50, MediaQuery.of(context).size.width * 0.4,"Guardar Cambios", () { }),
                          subtitle("Cambio de Contraseña"),
                          container_password(),
                          espacio_vertical(10),
                        ],
                      )
                    )
              )
            ],
          )
          ,
        );
  }
  Widget espacio_vertical(double alto){
    return SizedBox(
      height: alto,
    );
  }
  Widget espacio_horizontal(double ancho){
    return SizedBox(
      height: ancho,
    );
  }

  Widget subtitle(String subtitulo){
    return Container(
      margin: EdgeInsets.only(top:20,bottom: 10),
      child: Text(subtitulo,
          style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.grey
      ),
      )
    );
  }

  Widget informacion_user(){
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            dato_user("Nombre Usuario",usuario),
            espacio_vertical(7),
            dato_user("Email",email),
            espacio_vertical(7),
            dato_user("Movil",movil),
            espacio_vertical(5),
          ],
        ),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black)
        ),
      );
  }

  Widget dato_user(String dato,TextEditingController controlador){
    controlador.text="Dato de Usuario";
    return TextFormField(
      controller:controlador,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black
              )
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color:Color(0xff6B8B59)
              )
          ),
        suffixIcon: IconButton(
          icon: Icon(
          Icons.edit ),
          color: Colors.black87,
          onPressed: (){
            setState( () {
            });
          },
        ),
        contentPadding: EdgeInsets.all(8),
        labelText: dato,
        labelStyle: TextStyle(color:
        Color(0xff6B8B59
        )
        ),

      ),
    );
  }

  Widget container_password(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          password("Password Actual","Paswword Actual",contra),
          espacio_vertical(7),
          password("Password Nuevo","Paswword Nuevo",contra_actual),
          espacio_vertical(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [  BottomGreen(50, MediaQuery.of(context).size.width * 0.4,"Cambiar Contraseña", () { }),],
          ),
          espacio_vertical(5),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)
      ),
    );
  }

  Widget password(String valor,String dato,TextEditingController controlador){
    controlador.text=valor;
    return TextFormField(
      controller:controlador,
      obscureText: contra_invisible,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black
            )
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color:Color(0xff6B8B59)
            )
        ),
        suffixIcon: IconButton(
          icon: Icon(
              contra_invisible ? Icons.visibility : Icons.visibility_off),
          color: Colors.black87,
          onPressed: (){
            setState( () {
              contra_invisible = !contra_invisible;
            });
          },
        ),
        contentPadding: EdgeInsets.all(8),
        labelText: dato,
        labelStyle: TextStyle(color:
        Color(0xff6B8B59
        )
        ),
      ),
    );
  }



}