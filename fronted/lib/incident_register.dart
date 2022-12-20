import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/boton_verde.dart';
import 'package:firebase_flutter/avatar_user.dart';
import 'package:firebase_flutter/text_user.dart';

class IncidentRegister extends StatefulWidget {

  State<IncidentRegister> createState() => IncidentRegisterState();
}

class IncidentRegisterState extends State<IncidentRegister> {
  int nr_agraviado=1;
  String genero="";
  int edad=0;
  String monto_perdido;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: [
          Stack(
            children: [
              Positioned(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black,
                        height: 150,
                      ),
                      SizedBox(
                        height: 42,
                        //color: Colors.grey,
                      ),
                    ],
                  )
              ),
              Positioned(
                  top: 30,
                  right: 30,
                  left: 30,
                  child: Center(
                    child:Container(
                      width: MediaQuery.of(context).size.width*0.85,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextUser(),
                          AvatarUser(),
                        ],
                      ) ,
                    )
                    ,
                  )
              ),
              Positioned(
                  top: 70,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child:Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/look_aguila.png"),
                          radius: 58,
                        ),
                      ),
                    ),
                  )
              )

            ],
          ),
          Form(
              child: Container(
              width: MediaQuery.of(context).size.width*0.9,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  containerAgraviado(),
                  SizedBox(
                    height: 5,
                  ),
                  containerAsalto(),

                ],
              ) ,
              )
          )
        ],

      )
    );

  }
  Widget addAgraviado(){
    return Container(
      margin: EdgeInsets.only(top:5),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5,bottom: 5),
            child: Text(
              "Agraviado ${nr_agraviado}",
            ),
          ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //_genero(),
              _edad_genero()
            ],

          ),
        )

        ],
      ),
    );
  }


  Widget _edad_genero() {
    return Row(
      children: [
        Expanded(child:
        Container(
          //margin: EdgeInsets.only(top: 20),
        child: TextFormField(
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
            width: 50,
            padding: EdgeInsets.all(2),
            //margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black87,
                 width: 0.5,
                style: BorderStyle.solid
                 )
              ),
          
          child: DropdownButton(
            onChanged: null,
            hint: Text(
                "Seleccione su genero",
            ),
            items: <String>["Hombre","Mujer","Otro"].map((String select) {
              return DropdownMenuItem(
                value: select,
                child: Text(
                    select
                ),
              );
            }).toList(),
          ) ,
        ))



    ],
    );
  }

  Widget containerAgraviado(){
    return Container(
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
                        child:
                        Icon(
                            Icons.person_remove
                        )
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
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
          addAgraviado()
        ],
      ),
    );
  }

  Widget containerAsalto(){
    return Container(
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Datos sobre la perdida",
                  ),
                  Column(
                    children: [
                      Text(
                        "Seleccione entre que rangos se encuentra el monto perdido",
                      ),
                      Column(
                        children: [
                          RadioListTile(
                            title: Text("Menos de 500"),
                            value: 1,
                            groupValue: monto_perdido,
                            onChanged: (value){
                              setState(() {
                                monto_perdido = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("500-1000"),
                            value: 2,
                            groupValue: monto_perdido,
                            onChanged: (value){
                              setState(() {
                                monto_perdido = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("1000-3000"),
                            value: 3,
                            groupValue: monto_perdido,
                            onChanged: (value){
                              setState(() {
                                monto_perdido = value.toString();
                              });
                            },
                          )
                        ],
                      )
                    ],
                  )

                ]
            ),
          ),
        ],
      ),
    );
  }
}