import 'package:firebase_flutter/agraviado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/Incidencia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/Incidencia_BaseDatos.dart';
import 'package:firebase_flutter/boton_verde.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoboCrud extends StatefulWidget {
  State<RoboCrud> createState() => RoboCrudState();
}

class RoboCrudState extends State<RoboCrud> {

  CameraPosition _posicionInicial =
  CameraPosition(target: LatLng(-12.046130, -77.030686), zoom: 11.0);

  GoogleMapController _controllerMap;
  LatLng _ultimoTap=LatLng(-12.046130, -77.030686);


  TextEditingController id_robo = TextEditingController();
  List<TextEditingController> generos=[TextEditingController()];//Por defecto 1 agraviado
  List<TextEditingController> edades =[TextEditingController()];
  List<TextEditingController> pertenencias =[TextEditingController()];
  TextEditingController modalidad = TextEditingController();
  TextEditingController monto = TextEditingController();
  TextEditingController numAtacantes = TextEditingController();
  TextEditingController ubicacionx = TextEditingController();
  TextEditingController ubicaciony = TextEditingController();
  int indice_agraviadoactual=0;
  int indice_pertenenciaactual=0;
  List<Widget> newagraviados = [];
  List<Widget> newpertenencias=[];

  creandoRobo() async {
    try {
      int i=0;
      int j=0;
      IncidenciaBD bd_robo = IncidenciaBD();
      Robo robonuevo = Robo();
      //Para cada agraviado
      while(i<=this.indice_agraviadoactual){
        Agraviado agraviado=Agraviado();
        agraviado.genero=generos[i].text;
        agraviado.edad=int.parse(edades[i].text);
        robonuevo.agregarAgraviado(agraviado);
        i++;
      }
      while(j<=this.indice_pertenenciaactual){
        String pertenencia=this.pertenencias[j].text;
        robonuevo.agregarPertenencia(pertenencia);
        j++;
      }
      robonuevo.modalidad=modalidad.text;
      robonuevo.numAtacantes=int.parse(numAtacantes.text);
      robonuevo.monto=double.parse(monto.text);
      robonuevo.ubicacionx=_ultimoTap.latitude;
      robonuevo.ubicaciony=_ultimoTap.longitude;


      await bd_robo.createRobo(robonuevo);
      print("Robo registrado con exito");
    } catch (e) {
      print("Error .... ${e.toString()}");
    }
  }

  leyendoRobo() async {
    try {
      Robo roboleido;
      int i=0;
      int j=0;
      IncidenciaBD bd_robo = IncidenciaBD();
      roboleido= await bd_robo.getById(id_robo.text.trim());
      if (roboleido != null) {
        print("MOSTRANDO ROBO LEIDO POR CONSOLA");
        print("Datos de agraviados");
        while(i<roboleido.agraviados.length){
          print("Agraviado $i -> ${roboleido.agraviados[i]}");
          i++;
        }
        while(j<roboleido.pertenencias.length){
          print("Pertenencia -> ${roboleido.pertenencias[j]}");
          j++;
        }
        print("Modalidad -> ${roboleido.modalidad}");
        print("Monto -> ${roboleido.monto}");
        print("NroAsaltantes -> ${roboleido.numAtacantes}");
        print("UbicacionX -> ${roboleido.ubicacionx}");
        print("UbicacionY -> ${roboleido.ubicaciony}");
        print("Tiempo -> ${roboleido.fecha_hora}");
      } else {
        print("No existe la zona");
      }
    } catch (e) {
      print("Error .... ${e.toString()}");
    }
  }



  Widget addAgraviado(int indice){
    return Container(
      margin: EdgeInsets.only(top:5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5,bottom: 5),
            child: Text(
              "Agraviado ",
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _edad_genero(indice),
              ],
            ),
          )

        ],
      ),
    );
  }
  void nuevoAgraviado(){
    //Agregando un controlador por cada nuevo agraviado
    TextEditingController genero = TextEditingController();
    TextEditingController edad = TextEditingController();
    this.generos.add(genero);
    this.edades.add(edad);
    setState((){
      this.indice_agraviadoactual++;//Aumenta el numero de agraviados
      //Agregando agraviados
      newagraviados.add(addAgraviado(indice_agraviadoactual));
    }
    );
  }



  void borrarAgraviado(){
    //Agregando un controlador por cada nuevo agraviado
    if(indice_agraviadoactual!=0){
      this.generos.removeLast();
      this.edades.removeLast();
      setState((){
        this.indice_agraviadoactual--;//Disminuye el numero de agraviados
        //Agregando agraviados
        newagraviados.removeLast();
      }
      );
    }
    else{
      print("No es posbile eliminar agraviados");
    }
  }


  void nuevoPertenencia(){
    //Agregando un controlador por cada nuevo agraviado
    TextEditingController valor = TextEditingController();
    this.pertenencias.add(valor);
    setState((){
      this.indice_pertenenciaactual++;//Aumenta el numero de agraviados
      //Agregando agraviados
      newpertenencias.add(addPertenencia(indice_pertenenciaactual));
    }
    );
  }


  void borrarPertenencia(){
   //Agregando un controlador por cada nuevo agraviado
   if(indice_pertenenciaactual!=0){
     this.pertenencias.removeLast();
   setState((){
       this.indice_pertenenciaactual--;//Disminuye el numero de agraviados
       //Agregando agraviados
       newpertenencias.removeLast();
     }
     );
   }
   else{
     print("No es posbile eliminar pertenencias");
   }
  }

  Widget _edad_genero(int indice) {
    return Row(
      children: [
        Expanded(child:
        Container(
          //margin: EdgeInsets.only(top: 20),
          child: TextFormField(
            controller: this.edades[indice],
            decoration:  InputDecoration(
                contentPadding: EdgeInsets.all(17),
                hintText: 'Edad',
                label: Text("Edad"),
                hintStyle: TextStyle(color:Colors.black87),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black87,
                    )
                )
            ),
          ),
        )

        ),
        SizedBox(
          width: 5,
        ),
        Expanded(child:
        Container(
          //margin: EdgeInsets.only(top: 20),
          child: TextFormField(
            controller: this.generos[indice],
            decoration:  InputDecoration(
                contentPadding: EdgeInsets.all(17),
                hintText: 'Genero',
                label: Text("Genero"),
                hintStyle: TextStyle(color:Colors.black87),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black87,
                    )
                )
            ),
          ),
        )
        )
      ],
    );
  }

  Widget containerAgraviado(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black,
                        width: 3
                    )
                )
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Datos del agraviado o agraviados",
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap:(){
                            borrarAgraviado();
                          },
                          child:
                          Icon(
                              Icons.person_remove
                          )
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                      onTap:(){
                      nuevoAgraviado();
                      },
                          child:
                          Icon(
                              Icons.person_add_alt_1
                          )
                      )
                    ],
                  )
                ]
            ),
          ),
          addAgraviado(0),
          Column(
            children:newagraviados
          )
        ],
      ),
    );
  }

  Widget containerRobo(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black,
                        width: 3
                    )
                )
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Datos del asalto",
                  ),
                ]
            ),
          ),
          SizedBox(
            height: 5,
          ),
          text_dato("Modalidad Robo","modalidad","modalidad",this.modalidad),
          SizedBox(
            height: 5,
          ),
          text_dato("Numero asaltantes","nroAsaltantes","nroAsaltantes",this.numAtacantes),
          SizedBox(
            height: 5,
          ),
          text_dato("Monto robado","monto","monto",this.monto),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget text_dato(String texto,String datohint,String datolabel,TextEditingController controlador) {
    return Row(
      children: [
        Expanded(
            child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                      ),Container(
                    //margin: EdgeInsets.only(top: 20),
                      child: Text(
                          texto
                      )
                  )
                  ],
         )

        ),

        Expanded(child:
        Container(
          //margin: EdgeInsets.only(top: 20),
          child: TextFormField(
            controller: controlador,
            decoration:  InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: datohint,
                label: Text(datolabel),
                hintStyle: TextStyle(color:Colors.black87),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black87,
                    )
                )
            ),
          ),
        )
        )
      ],
    );
  }


  Widget containerpertenencia(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black,
                        width: 3
                    )
                )
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pertenencias Robadas",
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap:(){
                            nuevoPertenencia();
                          },
                          child:
                          Icon(
                              Icons.add
                          )
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap:(){
                            borrarPertenencia();
                          },
                          child:
                          Icon(
                              Icons.remove
                          )
                      )
                    ],
                  )
                ]
            ),
          ),
          addPertenencia(0),
          Column(
            children: newpertenencias,
          ),
        ],
      ),
    );
  }

  Widget addPertenencia(int indice){
    return Container(
      margin: EdgeInsets.only(top:5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Row(
      children: [
      Expanded(
          child: Row(
              children: [
              SizedBox(
              width: 10,
              ),Container(
              //margin: EdgeInsets.only(top: 20),
                  child: Text(
                      "Pertenencia Robada"
                  )
               )
              ],
        )

    ),

    Expanded(child:
    Container(
        //margin: EdgeInsets.only(top: 20),
        child: TextFormField(
          controller: this.pertenencias[indice],
          decoration:  InputDecoration(
            contentPadding: EdgeInsets.all(10),
              hintText: "Pertenencia",
              label: Text("Pertenencia"),
              hintStyle: TextStyle(color:Colors.black87),
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                color: Colors.black87,
                )
              )
          ),
        ),
    )
    )

    ],
    )
        ],
      ),
    );
  }

  Widget containerLugar(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black,
                        width: 3
                    )
                )
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Datos del lugar del asalto",
                  ),
                ]
            ),
          ),
          SizedBox(
            height: 5,
          ),
          text_dato("Ubicacionx","ubicacionx","ubicacionx",this.ubicacionx),
          SizedBox(
            height: 5,
          ),
          text_dato("Ubicaciony","ubicaciony","ubicaciony",this.ubicaciony),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
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

  Widget editar(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          subtitle("Leer Robo"),
          Container(
            child: TextFormField(
              controller: id_robo,
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: "Id_robo",
                label: Text("Id_robo"),
                hintStyle: TextStyle(color:Colors.black87),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black87,
                      )
                  )
                ),
            ),
    ),
          SizedBox(
            height: 10,
          ),
          BottomGreen(
              50,
              MediaQuery.of(context).size.width * 0.4,
              "Mostrar Robo",leyendoRobo
          ),
        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      markers: {
        Marker(
          markerId: MarkerId("ZonaRobo"),
          position: _ultimoTap ,
        )
      },
      onMapCreated: onMapCreated,
      initialCameraPosition: _posicionInicial,
      onTap: (LatLng pos) {
        setState(() {
          _ultimoTap = pos;
        });
      },
    );

    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SizedBox(
            width: 500.0,
            height: 400.0,
            child: googleMap,
          ),
        ),
      ),
    ];


    void irZona(){
      Navigator.pushNamed(context,"consult");
    }

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                subtitle("Registrar Robo"),
                containerAgraviado(),
                containerRobo(),
                containerpertenencia(),
                //containerLugar(),
                subtitle("Seleccion Zona Robo"),
                Container(
                    child: Column(
                      children: columnChildren,
                    ),
                  ),
                BottomGreen(
                    50,
                    MediaQuery.of(context).size.width * 0.4,
                    "Registrar Robo",creandoRobo
                ),
                SizedBox(height: 10,),
                BottomGreen(
                    50,
                    MediaQuery.of(context).size.width * 0.4,
                    "Consultar Zona",irZona
                ),
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