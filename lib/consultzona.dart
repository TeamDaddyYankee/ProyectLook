import 'package:firebase_flutter/agraviado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/Incidencia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/Incidencia_BaseDatos.dart';
import 'package:firebase_flutter/boton_verde.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConsultZona extends StatefulWidget {
  State<ConsultZona> createState() => ConsultZonatate();
}

class ConsultZonatate extends State<ConsultZona> {

  CameraPosition _posicionInicial =
  CameraPosition(target: LatLng(-12.046130, -77.030686), zoom: 11.0);

  GoogleMapController _controllerMap;
  LatLng _ultimoTap=LatLng(-12.046130, -77.030686);
  bool leido=false;
  Map<MarkerId, Marker> _marcadores = <MarkerId, Marker>{};
  int _contadorIdMarcador = 1;

   leyendoRobos() async {
    try {
      int ind=1;
      Robo roboleido;
      IncidenciaBD bd_robo = IncidenciaBD();
      QuerySnapshot querySnapshot = await bd_robo.robosref.get();
      for(var cursor in querySnapshot.docs){
        _anadir(cursor.get("ubicacionx"), cursor.get("ubicaciony"));
      }
      print("Marcadores cargados");
      /*for(Robo robo in robos){
        print("${robo.monto} ${robo.ubicaciony}");
        marcadores.add(newMarcador(robo.ubicacionx,robo.ubicaciony,ind));
        ind++;
      }*/
      leido=true;
      print(_contadorIdMarcador);
    }catch (e) {
      print("Error .... ${e.toString()}");
    }
  }


  void _anadir(double lat,double log) {
    LatLng position=LatLng(lat, log);
    final String cadenaIdMarcador = 'marcador_id_$_contadorIdMarcador';
    _contadorIdMarcador++;
    final MarkerId idMarcador = MarkerId(cadenaIdMarcador);

     Marker marcador = Marker(
      markerId: idMarcador,
      position: position,
      infoWindow: InfoWindow(
          title: cadenaIdMarcador,
          snippet: 'info'
      ),
      draggable: false,
    );
    setState(() {
      _marcadores[idMarcador] = marcador;
      print(idMarcador);
    });
  }




  Widget subtitle(String subtitulo) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Text(
          subtitulo,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),
        ));
  }


  @override
  Widget build(BuildContext context) {
    if(!leido){
      leyendoRobos();
    }
    final GoogleMap googleMap = GoogleMap(
      markers:Set<Marker>.of(_marcadores.values),
      onMapCreated: onMapCreated,
      initialCameraPosition: _posicionInicial,
    );

    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: googleMap,
          ),
        ),
      ),
    ];



    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              subtitle("Consultar Zona"),
              Container(
                child: Column(
                  children: columnChildren,
                ),
              ),
              SizedBox(height: 10,)
              //editar(),
            ],
          ),

        )
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controllerMap = controller;
    });
  }
}