import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/boton_verde.dart';

class LoginScreen extends StatefulWidget {
  BuildContext contexto;
  State<LoginScreen> createState() => LoginScreenState();
  LoginScreen(this.contexto);
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController contra=TextEditingController();
  TextEditingController email=TextEditingController();
  final keyform_login = GlobalKey<FormState>();
  bool contra_visible = true;

  validarLogin()async{
    bool exist=false;
    try{
      CollectionReference ref=FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuarios = await ref.get();
      if(usuarios.docs.length!=0){
        for(var userdoc in usuarios.docs){
          //print(userdoc.id);//Key del Documento
          if(userdoc.get("email") == email.text && userdoc.get("password") == contra.text){
             exist=true;
             print("Lectura con exito");
             //Lo mandas a la interfaz principal
             break;
          }
        }
      }
      if(!exist){
        mensaje_exito(widget.contexto,"Los datos ingresados no coinciden con ninguna cuenta");
      }
    }
    catch(e){
        print("Error .... ${e.toString()}");
    }
  }


  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    email.dispose();
    contra.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/fondo_look.png"),
            ),
            Container(
              margin: EdgeInsets.only(top:30,bottom: 4),
              child:Text("INICIO DE SESION",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                ),
              ),

            ),
           Form(
             key: keyform_login,
            child: Container(
            margin: EdgeInsets.only(top: 10),
            width:MediaQuery.of(context).size.width * 0.8 ,
            alignment: Alignment.center,
            child:Column(
              children: [
                _email(),
                espacio_vertical(10),
                _password(),
                espacio_vertical(20),
                Container(
                  alignment: Alignment.topRight,
                  child:InkWell(
                    child: Text(
                      "Olvidaste tu contraseña?",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color(0xff6B8B59),
                          shadows: [
                            Shadow(
                                color: Colors.grey,
                                offset: Offset(0.5,0)
                            )
                          ]
                      ),
                    ),
                  ),
                ),
                espacio_vertical(20),
                BottomGreen(50,MediaQuery.of(context).size.width * 0.4,"Iniciar Sesion",loginUser),
                espacio_vertical(20),
                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Aun no tiene una cuenta?"),
                        InkWell(
                          child: Text(
                            "Registrarse",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff6B8B59)
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            )
           ))
          ],
        ),
      );
}

void  loginUser(){
  //Si la validacion es exitosa
  validarLogin();
  if (keyform_login.currentState.validate()){
    print("Aceptable");
    validarLogin();
  }
  else{
    print("Error con la validacion");
  }
}

  void mensaje_exito(@required BuildContext context,String mensaje){
    final snackBar=SnackBar(
      content: Text( mensaje ,
        style: TextStyle(
            color: Colors.black87
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor:Color(0xff6B8B59),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  String validarEmail(String value){
    if(value.isEmpty){
      return "Porfavor ingrese un correo electronico";
    }
    if(!_emailRegExp.hasMatch(value.toLowerCase())){
      return "El correo ingresado no cumple con el formato";
    }
    return null;
  }
  String validarContra(String value){
    if(value.isEmpty){
      return "Pofavor ingrese una contraseña";
    }
    if(value.length < 9){
      return "La contraseña debe contener 9 o mas caracteres";
    }
    return null;
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

  Widget _email() {
    return
      TextFormField(
          validator: (value){
            return validarEmail(value);
          },
        controller: email,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black87,
              ),
              hintText: 'Email',
              hintStyle: TextStyle(color:Colors.black87),
              labelText: 'Email',
              labelStyle: TextStyle(color:
              Color(0xff6B8B59
              )
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black87,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color:Color(0xff6B8B59)
                  )
              )
          )
      );
  }


  Widget _password() {
    return
      TextFormField(
        validator: (value){
          return validarContra(value);
        },
        obscureText: contra_visible,
        controller: contra,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                    contra_visible ? Icons.visibility : Icons.visibility_off),
                color: Colors.black87,
                onPressed: (){
                  setState( () {
                    contra_visible = !contra_visible;
                  });
                },
              ),
              contentPadding: EdgeInsets.all(8),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black87,
              ),
              hintText: 'Password',
              hintStyle: TextStyle(color:Colors.black87),
              labelText: 'Password',
              labelStyle: TextStyle(color:
              Color(0xff6B8B59
              )
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black87,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color:Color(0xff6B8B59)
                  )
              )
          )
      );
  }

}