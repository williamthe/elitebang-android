import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import '../myenv.dart';

class FormTambah extends StatefulWidget{
  @override
  State<FormTambah> createState() => _FormTambahState();
}

class _FormTambahState extends State<FormTambah> {

  MyEnvironments env = new MyEnvironments();

  String tanggal = '';
  String nama = '';
  String waktu = '';
  String tempat = '';

  late BuildContext updel;
  @override
  Widget build(BuildContext context) {

    return Container(
      height : (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.82,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsetsDirectional.all(5),
                height: 180,
                decoration: BoxDecoration(
                  // border: BorderDirectional(),
                    borderRadius: BorderRadius.circular(20),
                    color: CupertinoColors.white
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex:3,
                      child: Container(
                        child: Text('Nama',
                          style: TextStyle(fontSize: 14, color: Colors.black,

                          ),
                        ),
                        padding: EdgeInsetsDirectional.all(13),
                        //color: Colors.lightBlue,
                        decoration: BoxDecoration(
                          //   color: Colors.black12,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                          padding: EdgeInsetsDirectional.all(15),
                          child: TextField(

                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.numbers_sharp)),
                            ),
                            onChanged: (e){
                              nama = e;
                            },
                            minLines: 3,
                            maxLines: 5,
                            controller: TextEditingController(text: nama),
                          ),
                          decoration: BoxDecoration(border: Border(),
                            //color: Colors.black12
                          )
                      ),
                    ),
                  ],)
            ),
            Container(height: 10,),
            Container(
                padding: EdgeInsetsDirectional.all(5),
                height: 160,
                decoration: BoxDecoration(
                  // border: BorderDirectional(),
                    borderRadius: BorderRadius.circular(20),
                    color: CupertinoColors.white
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex:3,

                      child: Container(
                        child: Text('Tanggal',
                          style: TextStyle(fontSize: 14, color: Colors.black,

                          ),
                        ),
                        padding: EdgeInsetsDirectional.all(13),
                        //color: Colors.lightBlue,
                        decoration: BoxDecoration(
                          //   color: Colors.black12,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                          padding: EdgeInsetsDirectional.all(15),
                          child: TextField(

                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(onPressed: (){
                                showDatePicker(context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2099)).then((value) => setState((){
                                  tanggal = value.toString().split(" ")[0];
                                }));
                              }, icon: Icon(Icons.date_range)),
                            ),
                            onChanged: (e){
                              tanggal = e;
                            },
                            controller: TextEditingController(text: tanggal),
                          ),
                          decoration: BoxDecoration(border: Border(),
                            //color: Colors.black12
                          )
                      ),
                    ),
                  ],)
            ),
            Container(height: 10,),
            Container(
                padding: EdgeInsetsDirectional.all(5),
                height: 160,
                decoration: BoxDecoration(
                  // border: BorderDirectional(),
                    borderRadius: BorderRadius.circular(20),
                    color: CupertinoColors.white
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex:3,

                      child: Container(
                        child: Text('Waktu',
                          style: TextStyle(fontSize: 14, color: Colors.black,

                          ),
                        ),
                        padding: EdgeInsetsDirectional.all(13),
                        //color: Colors.lightBlue,
                        decoration: BoxDecoration(
                          //   color: Colors.black12,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                          padding: EdgeInsetsDirectional.all(15),
                          child: TextField(
                            style: TextStyle(fontFamily: 'Poppins'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(onPressed: (){
                                showTimePicker(context: context,
                                  initialTime: TimeOfDay.now()

                                ).then((value) => setState((){
                                  print(value);
                                  waktu = value.toString().substring(10,15);
                                }));
                              }, icon: Icon(Icons.access_time_rounded)),
                            ),
                            onChanged: (e){
                              waktu = e;
                            },
                            controller: TextEditingController(text: waktu),
                          ),
                          decoration: BoxDecoration(border: Border(),
                            //color: Colors.black12
                          )
                      ),
                    ),
                  ],)
            ),
            Container(height: 10,),
            Container(
                padding: EdgeInsetsDirectional.all(5),
                height: 180,
                decoration: BoxDecoration(
                  // border: BorderDirectional(),
                    borderRadius: BorderRadius.circular(20),
                    color: CupertinoColors.white
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex:3,

                      child: Container(
                        child: Text('Tempat',
                          style: TextStyle(fontSize: 14, color: Colors.black,

                          ),
                        ),
                        padding: EdgeInsetsDirectional.all(13),
                        //color: Colors.lightBlue,
                        decoration: BoxDecoration(
                          //   color: Colors.black12,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Container(
                          padding: EdgeInsetsDirectional.all(15),
                          child: TextField(

                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.texture)),
                            ),
                            minLines: 4,
                            maxLines: 10,
                            onChanged: (e){
                              tempat = e;
                            },
                            controller: TextEditingController(text: tempat),
                          ),
                          decoration: BoxDecoration(border: Border(),
                            //color: Colors.black12
                          )
                      ),
                    ),
                  ],)
            ),
            Container(height: 10,),
            Container(
                padding: EdgeInsetsDirectional.all(10),
                height: 70,
                decoration: BoxDecoration(
                  border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  //color: CupertinoColors.white
                ),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      //flex: 9,
                      child: Container(
                        //height: 60,
                          padding: EdgeInsetsDirectional.all(5),
                          child: TextButton(
                            child: Text('simpan',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,),),
                            onPressed: (){
                              simpan();
                            },
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                              ),
                              borderRadius: BorderRadiusDirectional.circular(10),
                              color: Colors.greenAccent
                          )
                      ),
                    ),
                  ],)
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {

      });
    });
  }

  Future<void> simpan() async {

    showDialog(context: context, builder: (BuildContext upd){
      updel = upd;
      return AlertDialog(
        title: Column(
          children: [
            Text( 'Menyimpan Data...' ),
            Center(child: new CircularProgressIndicator())
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');

    await http.post(
      Uri.https(env.apiUrl, 'api/agenda/create'),
      headers: {
        //'Content-Type' : 'aplication/json;',
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'tanggal' : tanggal,
        'nama' : nama,
        'tempat' : tempat,
        'waktu' : waktu,
      },
    ).then((value){
      var dec = jsonDecode(value.body);
      Navigator.of(updel).pop();
      if(dec['status'] == true){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Berhasil!'),
            content: Text(dec['message']),
          );
        });
      }
      else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Gagal!'),
            content: Text(dec['message']),
          );
        });
      }

    } );

  }

}