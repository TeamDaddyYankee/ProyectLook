import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/boton_verde.dart';

class RegisterScreen extends StatefulWidget {
  BuildContext contexto;
  State<RegisterScreen> createState() => RegisterScreenState();

  RegisterScreen(this.contexto);
  RegisterScreen.only();
}

class RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usuario=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController contra=TextEditingController();
  TextEditingController movil=TextEditingController();
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
                                      Text("Ya tiene una cuenta? "),
                                      InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(context, "login_user");
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
            mensaje(context_scafold,"El usuario ingresado ya existe");
            break;
          }
          else if(userdoc.get("email")==email.text){
            mensaje(context_scafold,"El email ingresado ya existe");
            break;
          }
          else if(userdoc.get("movil")==movil.text){
            mensaje(context_scafold,"El numero de celular ingresado ya existe");
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
      mensaje(context_scafold,"Registrado con exito! Bienvenido!");
      Navigator.pushNamed(context, "login_user");
    }
  }



  final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
String validarUsuario(String valor){
  if(valor.isEmpty){
    return "Porfavor ingrese un nombre de usuario";
  }
  //Si hay otras validaciones lo ingresas como otras condiciones
  if(valor.length < 5){
    return "El nombre de usuario debe tener 5 o mas caracteres";
  }
  if(!alphanumeric.hasMatch(valor)){
    return "El nombre de usuario solo debe contener digitos alfanumericos";
  }

  return null;
}

 final RegExp _movilRegExp= RegExp(r"^\d{9}$");

  String validarTelefono(String value){
    if(value.isEmpty){
      return "Pofavor ingrese un numero de celular";
    }
    if(value[0] != "9") {
      return "El numero ingresado debe empezar con 9";
    }
  if(value.length != 9){
      return "El formato del numero de celular es de 9 digitos";
  }

  if(!_movilRegExp.hasMatch(value)){
    //print(_movilRegExp.hasMatch(value));
    return "El numero ingresado solo debe contener digitos numericos";
  }
  return null;
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

void mensaje(@required BuildContext context,String mensaje){
  final snackBar=SnackBar(
    content: Text(mensaje,
    style: TextStyle(
        color: Colors.black87
    ),
    ),
    duration: Duration(seconds: 2),
    backgroundColor:Color(0xff6B8B59),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


Widget _usuario() {
    return
      TextFormField(
          controller: usuario,
          validator: (value) {
            return validarUsuario(value);
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
          return validarTelefono(value);
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
          return validarEmail(value);
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
          return(validarContra(value));
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