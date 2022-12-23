class Zona{
     String id_doc;
     String distrito;
     String horarioFrecuente;
     String id_user;
     String modalidadFrecuente;
     String nombreLugar;
     int ubigeo;
     int numAsaltos;

    Zona(this.id_doc);
    Zona.datos(this.distrito,this.horarioFrecuente,this.id_user,this.modalidadFrecuente,this.nombreLugar);

    //Convierte al usuario en un map para la base de datos
    Map<String,dynamic> toMap()=>{
      "distrito":distrito,
      "numAsaltos":numAsaltos,
      "id_usuario":id_user,
      "modalidadFrecuente":modalidadFrecuente,
      "horarioFrecuente":horarioFrecuente,
      "nombreLugar":nombreLugar,
      "ubigeo":ubigeo,
    };

    Zona.fromSnapshot(String id,Map<String,dynamic> zona){
      id_doc=id;
      distrito=zona["distrito"];
      horarioFrecuente=zona["horarioFrecuente"];
      id_user=zona["id_usuario"];
      modalidadFrecuente=zona["modalidadFrecuente"];
      nombreLugar=zona["nombreLugar"];
      ubigeo=zona["ubigeo"];
      numAsaltos=zona["numAsaltos"];
    }

    void setDistrito(String distrito){
      this.distrito=distrito;
    }
    
     String getDistrito(){
       return this.distrito;
     }

    void setHorarioFrecuente(String horario){
      this.horarioFrecuente=horario;
     }

    String getHorarioFrecuente(){
       return this.horarioFrecuente;
     }

    void setIdUser(String id_user){
      this.id_user=id_user;
    }

     String getIdUser(){
       return this.id_user;
     }

    void setModalidadFrecuente(String modalidad){
      this.modalidadFrecuente=modalidad;
    }

    String getModalidadFrecuente(){
       return this.modalidadFrecuente;
    }


    void setNombreLugar(String name){
      this.nombreLugar=name;
     }

     
    String getNombreLugar(){
       return this.nombreLugar;
    }


    void setUbigeo(int ubigeo){
      this.ubigeo=ubigeo;
    }

    int getUbigeo(){
       return this.ubigeo;
    }


    void setNumAsaltos(int asaltos){
      this.numAsaltos=asaltos;
    }

    int getNumAsaltos(){
       return this.numAsaltos;
    }

}