import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/boton_verde.dart';
import 'package:firebase_flutter/User.dart';
import 'package:firebase_flutter/Usuarios_BaseDatos.dart';

class EditUserScreen extends StatefulWidget {

  State<EditUserScreen> createState() => EditUserScreenState();

}

class EditUserScreenState extends State<EditUserScreen> {

  TextEditingController usuario=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController movil=TextEditingController();
  TextEditingController contra=TextEditingController();
  TextEditingController contra_actual=TextEditingController();
  final keyform_informacion = GlobalKey<FormState>();
  final keyform_cambioContra = GlobalKey<FormState>();
  bool contra_invisible = false;
  bool enabled_usuario=false;
  User user_conectado;

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
        user_conectado = ModalRoute.of(context).settings.arguments;
        if(!enabled_usuario){
          leerUser();
        }
        return Scaffold(
            body: SizedBox(
                child: Builder(
                    builder: (BuildContext context){
                      return SingleChildScrollView(
                        child:Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  color: Colors.black,
                                  height: MediaQuery.of(context).size.height *0.25,
                                )
                              ],
                            ),
                            Form(
                                child: Container(
                                    width: MediaQuery.of(context).size.width*0.9,
                                    alignment: Alignment.center,
                                    child:Column(
                                      children: [
                                        espacio_vertical(10),
                                        Form(
                                          key: this.keyform_informacion,
                                          child: informacion_user(),
                                        ),
                                        espacio_vertical(10),
                                        BottomGreen(50, MediaQuery.of(context).size.width * 0.4,"Guardar Cambios", guardarCambios),
                                        espacio_vertical(10),
                                        Form(
                                            key: this.keyform_cambioContra,
                                            child: container_password(),
                                        ),
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
                )
            )
        );
  }

  void  guardarCambios(){
    //Si la validacion es exitosa y esta editando
    if (keyform_informacion.currentState.validate() && this.enabled_usuario){
      print("Aceptable");
      actualizarUser();
    }
    else{
      print("Error con la validacion o no esta editando");
    }
  }

  void  cambiarContra(){
    //Si la validacion es exitosa
    if (keyform_informacion.currentState.validate() ){
      print("Aceptable");
      actualizarContra();
    }
    else{
      print("Error con la validacion ");
    }
  }

  actualizarUser()async{
        UsuariosBD userUpdate= UsuariosBD();
        user_conectado.setNombre(usuario.text);
        user_conectado.setEmail(email.text);
        user_conectado.setMovil(movil.text);
        await userUpdate.updateUser(user_conectado.id_doc,user_conectado.toMap());
        print("Usuario Actualizado");
  }

  actualizarContra()async{
      UsuariosBD userUpdate= UsuariosBD();
      //Si acierta con la contraseña actual
      if(user_conectado.getContra()==contra.text){
        user_conectado.setContra(contra_actual.text);
        await userUpdate.updateUser(user_conectado.id_doc,user_conectado.toMap());
        print("Contraseña cambiada");
      }
      else{
        //La contra es incorrecta
      }

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

  leerUser(){
    usuario.text=user_conectado.nombre_user;
    email.text=user_conectado.email;
    movil.text=user_conectado.movil;
  }



  Widget subtitle(String subtitulo){
    return Container(
      //margin: EdgeInsets.only(top:20,bottom: 10),
      child: Text(subtitulo,
          style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.grey
      ),
      )
    );
  }

  Widget iconEdit(){
    return IconButton(
        icon: Icon(
          Icons.edit
          ),
        color:enabled_usuario ? Color(0xff6B8B59) : Colors.black87,
        onPressed: (){
          setState( () {
            //Si el usuario esta desactivado
            enabled_usuario=!enabled_usuario;
            }
          );
        },
    );
  }


  Widget informacion_user(){
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                subtitle("Informacion de Usuario"),
                iconEdit()
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
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
    return TextFormField(
      enabled: enabled_usuario,
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
        contentPadding: EdgeInsets.all(8),
        labelText: dato,
        labelStyle: TextStyle(color:
        Color(0xff6B8B59
        )
        ),
      ),
    );
  }

  Widget iconPassword(){
    return IconButton(
      icon: Icon(
          contra_invisible ? Icons.visibility : Icons.visibility_off),
      color: Colors.black87,
      onPressed: (){
        setState( () {
          contra_invisible = !contra_invisible;
        });
      },
    );
  }

  Widget container_password(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(children: [
            subtitle("Cambio de Contraseña"),
            iconPassword()
          ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          password("Password Actual","Paswword Actual",contra),
          espacio_vertical(7),
          password("Password Nuevo","Paswword Nuevo",contra_actual),
          espacio_vertical(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [  BottomGreen(50, MediaQuery.of(context).size.width * 0.4,"Cambiar Contraseña", cambiarContra),],
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
    return TextFormField(
      controller:controlador,
      obscureText: contra_invisible,
      decoration: InputDecoration(
        hintText: valor,
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