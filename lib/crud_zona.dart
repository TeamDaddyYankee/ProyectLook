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

class ZonaCrudState extends State<ZonaCrud> {
  TextEditingController id_zona = TextEditingController();
  TextEditingController distrito = TextEditingController();
  TextEditingController horario = TextEditingController();
  TextEditingController modalidad = TextEditingController();
  TextEditingController lugar = TextEditingController();
  TextEditingController ubigeo = TextEditingController();
  TextEditingController numAsaltos = TextEditingController();
  TextEditingController id_user = TextEditingController();
  //Para edit y read
  TextEditingController distrito2 = TextEditingController();
  TextEditingController horario2 = TextEditingController();
  TextEditingController modalidad2 = TextEditingController();
  TextEditingController lugar2 = TextEditingController();
  TextEditingController ubigeo2 = TextEditingController();
  TextEditingController numAsaltos2 = TextEditingController();
  TextEditingController id_user2 = TextEditingController();

  bool enabledcampo = false;
  Zona zonaleida=Zona();

  creandoZona() async {
    try {
      ZonaBD bd_zona = ZonaBD();
      Zona zonanueva = Zona();
      zonanueva.setDistrito(distrito.text);
      zonanueva.setHorarioFrecuente(horario.text);
      zonanueva.setModalidadFrecuente(modalidad.text);
      zonanueva.setNombreLugar(lugar.text);
      zonanueva.setUbigeo(int.parse(ubigeo.text));
      zonanueva.setNumAsaltos(int.parse(numAsaltos.text));
      zonanueva.setIdUser(id_user.text);
      await bd_zona.createZona(zonanueva);
      print("Zona registrada con exito");
    } catch (e) {
      print("Error .... ${e.toString()}");
    }
  }

  leyendoZona() async {
    try {
      ZonaBD bd_zona = ZonaBD();
      //En realidad habra un proceso
      zonaleida = await bd_zona.getById(id_zona.text.trim());
      if (zonaleida != null) {
        zonaleida.id_doc=id_zona.text;
        leerZona();
      } else {
        print("No existe la zona");
      }
    } catch (e) {
      print("Error .... ${e.toString()}");
    }
  }

  Zona leerZona() {
    distrito2.text = zonaleida.distrito;
    modalidad2.text = zonaleida.modalidadFrecuente;
    horario2.text = zonaleida.horarioFrecuente;
    ubigeo2.text = zonaleida.ubigeo.toString();
    numAsaltos2.text= zonaleida.numAsaltos.toString();
    lugar2.text = zonaleida.nombreLugar;
    id_user2.text = zonaleida.id_user;
  }

  actualizandoZona() async {
    try {
      ZonaBD bd_zona = ZonaBD();
      //En realidad habra un proceso
      //zonaleida = await bd_zona.getById(zonaleida.id_doc);

      if (zonaleida != null) {
          zonaleida.setDistrito(distrito2.text);
          zonaleida.setHorarioFrecuente(horario2.text);
          zonaleida.setModalidadFrecuente(modalidad2.text);
          zonaleida.setNombreLugar(lugar2.text);
          zonaleida.setUbigeo(int.parse(ubigeo2.text));
          zonaleida.setNumAsaltos(int.parse(numAsaltos2.text));
          zonaleida.setIdUser(id_user2.text);
          bd_zona.updateZona(id_zona.text,zonaleida.toMap());
          print("Zona actualizada");

      } else {
        print("No existe la zona");
      }
    } catch (e) {
      print("Error .... ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    //Si el campo esta deshabilitado
    if (!enabledcampo) {
      leerZona();
    }
    return Scaffold(
      body: SingleChildScrollView(
        child:Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                campo_zona(),
                SizedBox(
                  height: 20,
                ),
                read_editzona(),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
       )
      );
  }

  Widget subtitle(String subtitulo) {
    return Container(
        //margin: EdgeInsets.only(top:20,bottom: 10),
        child: Text(
      subtitulo,
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),
    ));
  }

  Widget campo_zona() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [subtitle("Crear Zona")],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          dato("Distrito", distrito),
          espacio_vertical(7),
          dato("HorarioFrecuente", horario),
          espacio_vertical(7),
          dato("ModalidadFrecuente", modalidad),
          espacio_vertical(5),
          dato("Lugar", lugar),
          espacio_vertical(7),
          dato("Ubigeo", ubigeo),
          espacio_vertical(7),
          dato("NroAsaltoss", numAsaltos),
          espacio_vertical(5),
          dato("id_user", id_user),
          espacio_vertical(5),
          BottomGreen(
            50,
            MediaQuery.of(context).size.width * 0.4,
            "Crear Zona",creandoZona
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
    );
  }

  Widget espacio_vertical(double alto) {
    return SizedBox(
      height: alto,
    );
  }
  Widget iconEdit() {
    return IconButton(
      icon: Icon(Icons.edit),
      color: enabledcampo ? Color(0xff6B8B59) : Colors.black87,
      onPressed: () {
        setState(() {
          //Si el usuario esta desactivado
          enabledcampo = !enabledcampo;
        });
      },
    );
  }

  Widget read_editzona() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [subtitle("Leer y Editar Zona")],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          espacio_vertical(5),
          Text("PRIMERO INGRESE EL ID_ZONA Y CLICK EN LEER ZONA"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Expanded(child: dato("Id_zona",id_zona)),
          Expanded(child:BottomGreen(50, MediaQuery.of(context).size.width * 0.3,"Leer Zona",leyendoZona)),
            ],
          ),
          espacio_vertical(10),
          Row(
            children: [Text("LUEGO DE LEER LA ZONA ,SELECCIONE EL ICONO Y EDITE")],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [iconEdit()],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Column(
            children: [
              datoread_update("Distrito", distrito2),
              espacio_vertical(7),
              datoread_update("HorarioFrecuente", horario2),
              espacio_vertical(7),
              datoread_update("ModalidadFrecuente", modalidad2),
              espacio_vertical(5),
              datoread_update("Lugar", lugar2),
              espacio_vertical(7),
              datoread_update("Ubigeo", ubigeo2),
              espacio_vertical(7),
              datoread_update("NroAsaltoss", numAsaltos2),
              espacio_vertical(5),
              datoread_update("id_user", id_user2),
              espacio_vertical(5),
            ],
          ),
          espacio_vertical(10),
          BottomGreen(50, MediaQuery.of(context).size.width * 0.4,
              "Actualizando Zona", actualizandoZona),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      );
  }

  Widget dato(String dato, TextEditingController controlador) {
    return TextFormField(
      controller: controlador,
      decoration: InputDecoration(
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B8B59))),
        contentPadding: EdgeInsets.all(8),
        labelText: dato,
        labelStyle: TextStyle(color: Color(0xff6B8B59)),
      ),
    );
  }

  Widget datoread_update(String dato, TextEditingController controlador) {
    return TextFormField(
      enabled: enabledcampo,
      controller: controlador,
      decoration: InputDecoration(
        border:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B8B59))),
        contentPadding: EdgeInsets.all(8),
        labelText: dato,
        labelStyle: TextStyle(color: Color(0xff6B8B59)),
      ),
    );
  }
}
