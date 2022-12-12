class ValidateField{
  final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
  final movilRegExp= RegExp(r"^\d{9}$");
  final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");

  String validarNombreUser(String valor){
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

    if(!movilRegExp.hasMatch(value)){
      //print(_movilRegExp.hasMatch(value));
      return "El numero ingresado solo debe contener digitos numericos";
    }
    return null;
  }

  String validarEmail(String value){
    if(value.isEmpty){
      return "Porfavor ingrese un correo electronico";
    }
    if(!emailRegExp.hasMatch(value.toLowerCase())){
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


}