import 'agraviado.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Robo {

  String id_doc;
  String modalidad;
  List<dynamic> agraviados;
  Timestamp fecha_hora;
  double ubicacionx;
  double ubicaciony;
  List<dynamic> pertenencias;
  int numAtacantes;
  double monto;

  Robo() {
    //Dando fecha actual
    this.fecha_hora = Timestamp.fromDate(DateTime.now());
    agraviados=[];
    pertenencias=[];
  }

  Robo.id(this.id_doc);



  Map<String, dynamic> toMap() => {
        "agraviados": agraviados,
        "modalidad": modalidad,
        "momento_robo": fecha_hora,
        "monto": monto,
        "numAtacantes": numAtacantes,
        "pertenencias": pertenencias,
        "ubicacionx": ubicacionx,
        "ubicaciony": ubicaciony,
  };

  Robo.fromSnapshot(String id, Map robo) {
    id_doc = id;
    agraviados = robo["agraviados"];
    modalidad = robo["modalidad"];
    fecha_hora = robo["momento_robo"];
    monto = robo["monto"];
    numAtacantes = robo["numAtacantes"];
    pertenencias = robo["pertenencias"];
    ubicacionx = robo["ubicacionx"];
    ubicaciony = robo["ubicaciony"];
  }

  void agregarAgraviado(Agraviado agraviado) {
    this.agraviados.add(agraviado.toMap());
  }

  void agregarPertenencia(String pertenencia) {
    this.pertenencias.add(pertenencia);
  }



}
