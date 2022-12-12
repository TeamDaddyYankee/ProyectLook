class User{
     String id_doc;
     String nombre_user;
     String email;
     String contra;
     String movil;
    User(this.id_doc);
    User.datos(this.nombre_user,this.email,this.movil,this.contra);

    //Convierte al usuario en un map para la base de datos
    Map<String,dynamic> toMap()=>{
      "email":email,
      "movil":movil,
      "nombreUser":nombre_user,
      "password":contra
    };

    User.fromSnapshot(String id,Map<String,dynamic> usuario){
      id_doc=id;
      nombre_user=usuario["nombreUser"];
      email=usuario["email"];
      contra=usuario["password"];
      movil=usuario["movil"];
    }

    void setContra(String password){
      this.contra=password;
    }
     String getContra(){
       return this.contra;
     }

    void setNombre(String name){
      this.nombre_user=name;
     }

     void setMovil(String cel){
      this.movil=cel;
    }

     void setEmail(String correo){
        this.email=correo;
     }

}