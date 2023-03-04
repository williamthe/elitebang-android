
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'index.dart';

class EditAgenda extends StatefulWidget{
  Map myData = {};
  EditAgenda(listData){
    this.myData = listData;
  }

  _EditAgenda createState() => _EditAgenda(myData);

}

class _EditAgenda extends State<EditAgenda>{
  Map myData = {};

  int id = 0;
  String tanggal = '';
  String nama = '';
  String tempat = '';
  String waktu = '';
  _EditAgenda(Map myData){
    this.myData   = myData;
    this.nama     = myData['nama']     == null ? '-' : myData['nama'];
    this.tanggal  = myData['tanggal']  == null ? '-' : myData['tanggal'];
    this.waktu    = myData['waktu']    == null ? '-' : myData['waktu'];
    this.tempat   = myData['tempat']   == null ? '-' : myData['tempat'];
    this.id   = myData['id']   == null ? 0 : myData['id'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          appBar: AppBar(title: Text('Edit '+nama,),
            centerTitle: true,
            leading: IconButton(onPressed: (){
              Navigator.of(context).pop();
            },icon: Icon(Icons.arrow_circle_left),),
          ),
          body:
          Column(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height- MediaQuery.of(context).padding.top- AppBar().preferredSize.height ) * 0.9,
                child: Expanded(
                  child: ListView(
                    children: [
                      Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(15,15,15,15),

                            ),

                            Container(
                              padding: EdgeInsets.fromLTRB(15,5,15,5),
                              child: TextField(
                                //text:'',
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),

                                    ),
                                    //prefixIcon: Icon(Icons.email_outlined),
                                    hintText: "Nama",
                                    labelText: "Nama"

                                ),
                                onChanged: (text){
                                  nama = text;
                                },
                                controller: TextEditingController(text: nama),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(15,5,15,5),
                              child: TextField(
                                //text:'',
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),

                                    ),
                                    //prefixIcon: Icon(Icons.email_outlined),
                                    hintText: "Tempat",
                                    labelText: "Tempat"

                                ),
                                onChanged: (text){
                                  tempat = text;
                                },
                                controller: TextEditingController(text: tempat),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(15,5,15,5),
                              child: TextField(
                                //text:'',
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),

                                    ),
                                    //prefixIcon: Icon(Icons.email_outlined),
                                    hintText: "Tanggal",
                                    labelText: "Tanggal",
                                    suffixIcon: IconButton(onPressed: (){
                                      showDatePicker(context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2099),

                                      ).then((value) {
                                        setState(() {
                                          tanggal = value.toString().split(' ')[0];
                                        });
                                      });
                                    }, icon: Icon(Icons.date_range))

                                ),
                                onChanged: (text){

                                },
                                controller: TextEditingController(text: tanggal),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(15,5,15,5),
                              child: TextField(
                                //text:'',
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),

                                    ),
                                    //prefixIcon: Icon(Icons.email_outlined),
                                    hintText: "Waktu",
                                    labelText: "Waktu",
                                    suffixIcon: IconButton(onPressed: (){
                                      showTimePicker(context: context,
                                          initialTime: TimeOfDay(hour: 10, minute: 00)).then((value) {
                                            setState((){
                                              waktu = value.toString().substring(10,15);
                                            });
                                      });
                                    }, icon: Icon(Icons.access_time_outlined))

                                ),
                                onChanged: (text){

                                },
                                controller: TextEditingController(text: waktu),
                              ),
                            ),

                          ],
                        ),
                      ), /* add child content here */
                    ),],
                  ),
                ),
              ),
              Container(
                width: 100,
                height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - AppBar().preferredSize.height ) * 0.07,
                padding: EdgeInsetsDirectional.all(8),
                //color: Colors.redAccent,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  color: Color.fromRGBO(1, 123, 255, 10)
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                      border: Border(),

                      //color: Color.fromRGBO(1, 123, 255, 10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: (){
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(title: Center(child: Text('Update Data?')),
                            actions: [
                              IconButton(onPressed: (){
                                      update();
                              }, icon: Icon(Icons.check_circle_outline)),
                              IconButton(onPressed: (){ return  Navigator.of(context).pop(); }, icon: Icon(Icons.close)),
                            ],
                          contentPadding: EdgeInsetsGeometry.infinity,);
                        },).then((value) => print(value));
                      }, child: Text('update',style: TextStyle(color: Colors.white, fontSize: 16),) ),
                      //IconButton(onPressed: (){}, icon: Icon(Icons.save, size: 28,color: Colors.white,),
                      //),
                    ],
                  ),),
              ),
            ],
          ),
        )
    );
  }

  Future<void> update() async {
  var _mytoken = await SessionManager().get('_token');

    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text( 'Silahkan Tunggu...' ),
        content: Text(""),
      );
    });
    print('mulai');
    var response = await http.post(
      Uri.https('api-litbang.btx.co.id', 'api/agenda/update'),
      headers: {
        //'Content-Type' : 'aplication/json;',
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
        'nama': nama,
        'tanggal' : tanggal,
        'waktu': waktu,
        'tempat': tempat,
      },
    ).then((value){
      var dec = jsonDecode(value.body);
      Navigator.of(context).pop();
      if(dec['status'] == true){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Update Berhasil!'),
            content: Text(""),
          );
        });
      }
      else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Update Gagal!'),
            content: Text(dec['message']),
          );
        });
      }

    } );

  }

}

