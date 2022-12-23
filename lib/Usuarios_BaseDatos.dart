import 'package:firebase_flutter/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsuariosBD {
  CollectionReference usuariosRef =
      FirebaseFirestore.instance.collection("Usuarios");

//Agregar un usuario a la base de datos
  Future<void> createUser(User usuario) async {
    await usuariosRef.add(usuario.toMap());
  }

  Future<void> updateUser(String iddoc, Map<String, dynamic> datos) async {
    final docUser = usuariosRef.doc(iddoc);
    docUser.update(datos);
  }

//Obtener usuario con el id de documento
  Future<User> getById(String id) async {
    User usuario;
    DocumentSnapshot document = await usuariosRef.doc(id).get();
    if (document.exists) {
      usuario = User.fromSnapshot(id, document.data());
    }
    return usuario;
  }

  //Retorna una lista de Usuarios de la base de datos
  Future<List<User>> get() async {
    QuerySnapshot querySnapshot = await usuariosRef.get();
    return querySnapshot.docs
        .map((ds) => User.fromSnapshot(ds.id, ds.data()))
        .toList();
  }

  //Retorna un usuario con el email indicado
  Future<User> getByEmail(String email) async {
    //Usuarios de la base de datos
    QuerySnapshot users =
        await usuariosRef.where("email", isEqualTo: email).get();
    //Si el usuario con el email existe,es solo un usuario
    if (users.docs.length != 0) {
      var documentUser = users.docs.first;
      return User.fromSnapshot(documentUser.id, documentUser.data());
    } else {
      return null;
    }
  }

  Future<bool> existData(String bdfield, String data) async {
    //Usuarios de la base de datos con la data indicada en el campo field indicado
    QuerySnapshot users =
        await usuariosRef.where(bdfield, isEqualTo: data).get();
    //Si existe un usuario con el dato dado
    if (users.docs.length != 0) {
      return true;
    }
    //Si es cero es pq no hay ningun usuario con el dato dado
    else {
      return false;
    }
  }
}
