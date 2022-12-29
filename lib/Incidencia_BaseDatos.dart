import 'package:firebase_flutter/Incidencia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IncidenciaBD {
  CollectionReference robosref = FirebaseFirestore.instance.collection("Robo");

//Agregar un robo a la base de datos
  Future<void> createRobo(Robo robo) async {
    await robosref.add(robo.toMap());
  }

//Actualizar robo en la base de datos
  Future<void> updateRobo(String iddoc, Map<String, dynamic> datos) async {
    final docRobo = robosref.doc(iddoc);
    docRobo.update(datos);
  }


//Obtener robo con el id de documento
  Future<Robo> getById(String id) async {
    Robo robo;
    DocumentSnapshot document = await robosref.doc(id).get();
    if (document.exists) {
      robo = Robo.fromSnapshot(id, document.data());
    }
    return robo;
  }

  //Retorna una lista de Robos de la base de datos
  Future<List<Robo>> get() async {
    QuerySnapshot querySnapshot = await robosref.get();
    return querySnapshot.docs
        .map((ds) => Robo.fromSnapshot(ds.id, ds.data()))
        .toList();
  }

  Future<bool> existData(String bdfield, String data) async {
    //Robos de la base de datos con la data indicada en el campo field indicado
    QuerySnapshot robos = await robosref.where(bdfield, isEqualTo: data).get();
    //Si existe un robo con el dato dado
    if (robos.docs.length != 0) {
      return true;
    }
    //Si es cero es pq no hay ningun usuario con el dato dado
    else {
      return false;
    }
  }
}
