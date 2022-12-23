import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/Zona.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/Zona_BaseDatos.dart';
import 'dart:io';
import 'package:firebase_flutter/boton_verde.dart';

class ZonaCrud extends StatefulWidget {
  State<ZonaCrud> createState() => ZonaCrudState();
}

Zona datosZonaNueva() {
  Zona zonanueva;
  print("Datos para la zona");
  stdout.write("Ingrese el distrito:");
  zonanueva.setDistrito(stdin.readLineSync());
  stdout.write("Ingrese el HorarioFrecuente:");
  zonanueva.setHorarioFrecuente(stdin.readLineSync());
  stdout.write(
      "Ingrese el id_user:"); //Esto en realidad sera una busqueda de datos pero por ahora ingrese un id_user manual
  zonanueva.setIdUser(stdin.readLineSync());
  stdout.write("Ingrese el ModalidadFrecuente:");
  zonanueva.setModalidadFrecuente(stdin.readLineSync());
  stdout.write("Ingrese el Lugar:");
  zonanueva.setNombreLugar(stdin.readLineSync());
  stdout.write("Ingrese ubigeo:");
  zonanueva.setUbigeo(int.parse(stdin.readLineSync()));
  stdout.write("Ingrese numAsaltos:");
  zonanueva.setNumAsaltos(int.parse(stdin.readLineSync()));
  return zonanueva;
}

creandoZona() async {
  try {
    ZonaBD bd_zona = ZonaBD();
    await bd_zona.createZona(datosZonaNueva());
    print("Zona registrada con exito");
  } catch (e) {
    print("Error .... ${e.toString()}");
  }
}

leyendoZona() async {
  Zona zonaleida;
  try {
    ZonaBD bd_zona = ZonaBD();
    //En realidad habra un proceso
    stdout.write("Ingrese id_zona:");
    String codigoid = stdin.readLineSync();
    zonaleida = await bd_zona.getById(codigoid);
    if (zonaleida != null) {
      print(zonaleida.toString());
    } else {
      print("No existe la zona");
    }
  } catch (e) {
    print("Error .... ${e.toString()}");
  }
}

actualizandoZona() async {
  Zona zonaleida;
  try {
    ZonaBD bd_zona = ZonaBD();
    //En realidad habra un proceso
    stdout.write("Ingrese id_zona:");
    String codigoid = stdin.readLineSync();
    zonaleida = await bd_zona.getById(codigoid);
    if (zonaleida != null) {
      int opcion = opcionZona();
      switch (opcion) {
        case 1:
          stdout.write("Ingrese nuevo distrito: ");
          zonaleida.setDistrito(stdin.readLineSync());
          bd_zona.updateZona(codigoid, zonaleida.toMap());
          break;
        case 2:
          stdout.write("Ingrese nuevo Nombre de lugar: ");
          zonaleida.setNombreLugar(stdin.readLineSync());
          bd_zona.updateZona(codigoid, zonaleida.toMap());
          break;
        case 3:
          stdout.write("Ingrese nuevo valor Numero Asaltos: ");
          zonaleida.setNumAsaltos(int.parse(stdin.readLineSync()));
          bd_zona.updateZona(codigoid, zonaleida.toMap());
          break;
      }
    } else {
      print("No existe la zona");
    }
  } catch (e) {
    print("Error .... ${e.toString()}");
  }
}

int opcionZona() {
  print("Ingrese el valor del campo que desea editar");
  print("1.Editar distrito");
  print("2.Editar Nombre del Lugar");
  print("3.Editar numero de asaltos");
  stdout.write("Digite un valor: ");
  return int.parse(stdin.readLineSync());
}

class ZonaCrudState extends State<ZonaCrud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          BottomGreen(50, MediaQuery.of(context).size.width * 0.4, "Crear Zona",
              creandoZona),
          SizedBox(
            height: 20,
          ),
          BottomGreen(50, MediaQuery.of(context).size.width * 0.4, "Leer Zona",
              leyendoZona),
          SizedBox(
            height: 20,
          ),
          BottomGreen(50, MediaQuery.of(context).size.width * 0.4,
              "Actualizando Zona", actualizandoZona),
          SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}
