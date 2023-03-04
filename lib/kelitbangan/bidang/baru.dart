
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:open_file/open_file.dart';
import '../../myenv.dart';

class FormBaru extends StatefulWidget{
  @override
  State<FormBaru> createState() => _FormBaruState();
}

class _FormBaruState extends State<FormBaru> {

  _FormBaruState(){

  }

  MyEnvironments env = new MyEnvironments();

  List listInstansi = [];

  int id = 0;
  String nama = '';
  String keterangan = '';

  late BuildContext simpan;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
                    child: Text('Nama Bidang',
                      style: TextStyle
                        (fontSize: 14,
                        color: Colors.black,

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
                    child: Text('Keterangan',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.abc_outlined)),
                        ),
                        minLines: 2,
                        maxLines: 10,
                        onChanged: (e){
                          keterangan = e;
                        },
                        controller: TextEditingController(text: keterangan),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  //flex: 9,
                  child: Container(
                    width: double.infinity,
                    //height: 60,
                      padding: EdgeInsetsDirectional.all(5),
                      child: TextButton(
                        child: Text('simpan',
                          style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,),),
                        onPressed: (){
                          store();
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
    );
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {

      });
    });
  }



  Future<void> store() async {
    simpanDialog();

    var _mytoken = await SessionManager().get('_token');
    var response = await http.post(
      Uri.https(env.apiUrl, 'api/kelitbangan/create-bidang'),
      headers: {
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'nama' : nama,
        'keterangan' : keterangan,

      },
    ).then((value){
      var dec = jsonDecode(value.body);
      print(dec);
      Navigator.of(simpan).pop();
      if(dec['status'] == true){

        showDialog(context: simpan, builder: (context){
          return AlertDialog(
            title: Text('Berhasil'),
            content: Text(dec['message']),
          );
        }).then((value) => resetForm());
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

  resetForm() {}

  simpanDialog(){
    showDialog(context: context, builder: (BuildContext sv) {
      simpan = sv;
      return AlertDialog(title: Column(
        children: [
          Center(child: new CircularProgressIndicator()),
          Text('Menyimpan Data')
        ],
      ),);
    },);
  }
}