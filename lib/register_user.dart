import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/boton_verde.dart';
import 'package:firebase_flutter/validate.dart';

class RegisterScreen extends StatefulWidget {
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usuario=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController contra=TextEditingController();
  TextEditingController movil=TextEditingController();
  ValidateField validate=ValidateField();
  final firestore=FirebaseFirestore.instance;
  final _keyform = GlobalKey<FormState>();
  bool contra_visible = true;
  BuildContext context_scafold;


  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    usuario.dispose();
    email.dispose();
    contra.dispose();
    movil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return Scaffold(
      body: SizedBox(
        child: Builder(
            builder: (BuildContext scaffoldContext){
              context_scafold=scaffoldContext;
              return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset("assets/fondo_look.png"),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:10,bottom:10),
                        child:Text("REGISTRO",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                          ),
                        ),
                      ),
                      Form(
                        key: _keyform,
                        child:Container(
                          margin: EdgeInsets.only(top: 10),
                          width:MediaQuery.of(context).size.width * 0.8,
                          alignment: Alignment.center,
                          child:Column(
                            children: [
                              _usuario(), // TextField usuario
                              espacio_vertical(10),
                              _email(), //TextField correo
                              espacio_vertical(10),
                              _password(),//TextField password
                              espacio_vertical(10),
                              _telefono(), //TextField telefono
                              terminos(),
                              espacio_vertical(10),
                              //Boton
                              BottomGreen(50,MediaQuery.of(context).size.width * 0.4,"Crear Cuenta",registerUser),
                              espacio_vertical(20),
                              Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Ya tiene una cuenta?"),
                                      InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(context,"login_user");
                                        },
                                        child: Text(
                                          "Iniciar Sesion",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff6B8B59)
                                          ),
                                        ),
                                      ),
                                      espacio_vertical(10),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
            }
        )
      )
    );
  }

  validarRegistro()async{
    bool valido=false;
    try{
      CollectionReference ref=FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuarios = await ref.get();
      if(usuarios.docs.length!=0){
        for(var userdoc in usuarios.docs){
          //Si existe un usuario con el mismo nombre
          if(userdoc.get("nombreUser")==usuario.text){
            mensaje("El usuario ingresado ya existe");
            break;
          }
          else if(userdoc.get("email")==email.text){
            mensaje("El email ingresado ya existe");
            break;
          }
          else if(userdoc.get("movil")==movil.text){
            mensaje("El numero de celular ingresado ya existe");
            break;
          }
          else{
            valido=true;
          }
        }
      }
      if(valido){
        //Ingresamos los datos del usuario a la base de datos
        await firestore.collection("Usuarios").doc().set(
            {
              "nombreUser":usuario.text,
              "email" : email.text,
              "password":contra.text,
              "movil" : movil.text
            }
        );
      }
    }
    catch(e){
      print("Error .... ${e.toString()}");
    }
  }


  void registerUser(){
    if (_keyform.currentState.validate()){
      validarRegistro();
      usuario.clear();
      email.clear();
      contra.clear();
      movil.clear();
      print("Registrado con Exito");
      mensaje("Registrado con exito! Bienvenido!");
      Navigator.pushNamed(context, "login_user");
    }
  }


Widget terminos(){
    return  Container(
        margin: EdgeInsets.only(top: 10),
        child:Text(
          "Al crear una cuenta, usted acepta los terminos de uso y la politica de privacidad de Look."
          ,style: TextStyle(
            fontSize: 15
        ),
        )
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

void mensaje(String mensaje){
  final snackBar=SnackBar(
    content: Text(mensaje,
    style: TextStyle(
        color: Colors.black87
    ),
    ),
    duration: Duration(seconds: 2),
    backgroundColor:Color(0xff6B8B59),
  );
  ScaffoldMessenger.of(context_scafold).showSnackBar(snackBar);
}


Widget _usuario() {
    return
      TextFormField(
          controller: usuario,
          validator: (value) {
            return validate.validarNombreUser(value);
          },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black87,
          ),
          hintText: 'Usuario',
          hintStyle: TextStyle(color:Colors.black87),
          labelText: 'Usuario',
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

  Widget _telefono() {
    return
      TextFormField(
        controller: movil,
        keyboardType: TextInputType.phone,
        validator: (value){
          return validate.validarTelefono(value);
        },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              prefixIcon: Icon(
                Icons.call,
                color: Colors.black87,
              ),
              hintText: 'Movil',
              hintStyle: TextStyle(color:Colors.black87),
              labelText: 'Movil',
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

  Widget _email() {
    return
      TextFormField(
        controller: email,
        validator: (value){
          return validate.validarEmail(value);
        },
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
        controller: contra,
        validator: (value){
          return validate.validarContra(value);
        },
         obscureText: contra_visible,
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