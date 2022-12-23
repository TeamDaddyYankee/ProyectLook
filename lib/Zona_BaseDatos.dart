import 'package:firebase_flutter/Zona.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ZonaBD {
  CollectionReference zonaref = FirebaseFirestore.instance.collection("Zona");

//Agregar un usuario a la base de datos
  Future<void> createZona(Zona zona) async {
    await zonaref.add(zona.toMap());
  }

  Future<void> updateZona(String iddoc, Map<String, dynamic> datos) async {
    final docZona = zonaref.doc(iddoc);
    docZona.update(datos);
  }

//Obtener zona con el id de documento
  Future<Zona> getById(String id) async {
    Zona zona;
    DocumentSnapshot document = await zonaref.doc(id).get();
    if (document.exists) {
      zona = Zona.fromSnapshot(id, document.data());
    }
    return zona;
  }

  //Retorna una lista de Usuarios de la base de datos
  Future<List<Zona>> get() async {
    QuerySnapshot querySnapshot = await zonaref.get();
    return querySnapshot.docs
        .map((ds) => Zona.fromSnapshot(ds.id, ds.data()))
        .toList();
  }

  Future<bool> existData(String bdfield, String data) async {
    //Usuarios de la base de datos con la data indicada en el campo field indicado
    QuerySnapshot zonas = await zonaref.where(bdfield, isEqualTo: data).get();
    //Si existe un usuario con el dato dado
    if (zonas.docs.length != 0) {
      return true;
    }
    //Si es cero es pq no hay ningun usuario con el dato dado
    else {
      return false;
    }
  }
}
