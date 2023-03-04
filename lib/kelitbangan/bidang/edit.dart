
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import '../../myenv.dart';


class FormEditBidang extends StatefulWidget{
  Map dataKelitbangan = {};
  FormEditBidang(Map data){
    this.dataKelitbangan = data;
  }
  @override
  State<FormEditBidang> createState() => _FormEditBidangState(dataKelitbangan);
}

class _FormEditBidangState extends State<FormEditBidang> {

  MyEnvironments env = new MyEnvironments();

  Map myData = {};

  String id = '0';
  String nama = '';
  String keterangan = '';

  double formFont = 13;


  _FormEditBidangState(Map myData){
    this.myData       = myData;
    this.id           = myData['id']           == null ? '-' : myData['id'].toString();
    this.nama         = myData['nama']         == null ? '-' : myData['nama'];
    this.keterangan   = myData['keterangan']   == null ? '-' : myData['keterangan'];

  }

  late BuildContext updel;
  @override
  Widget build(BuildContext context) {

    return Container(
      height : (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.82,
      child: ListView(
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
                          style: TextStyle(

                          ),
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
                          child: Text('update',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,),),
                          onPressed: (){
                            update();
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
                  SizedBox(width: 10,),
                  Expanded(
                    //flex: 9,
                    child: Container(
                      //height: 60,
                        padding: EdgeInsetsDirectional.all(5),
                        child: TextButton(
                          child: Text('hapus',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,),),
                          onPressed: (){
                            confirmDelete();
                          },
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                            ),
                            borderRadius: BorderRadiusDirectional.circular(10),
                            color: Colors.redAccent
                        )
                    ),
                  ),
                ],)
          ),
        ],
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


  Future<void> update() async {

    showDialog(context: context, builder: (BuildContext upd){
      updel = upd;
      return AlertDialog(
        title: Column(
          children: [
            Text( 'Mengupdate Data...' ),
            Center(child: new CircularProgressIndicator())
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');
     await http.post(
      Uri.https(env.apiUrl, 'api/kelitbangan/update-bidang'),
      headers: {

        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id,
        'nama' : nama,
        'keterangan' : keterangan,
      },
    ).then((value){
      var dec = jsonDecode(value.body);
      Navigator.of(updel).pop();
      if(dec['status'] == true){

        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Update Berhasil!'),
            content: Text(dec['message']),
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

  Future<void> delete() async {

    showDialog(context: context, builder: (BuildContext upd){
      updel = upd;
      return AlertDialog(
        title: Column(
          children: [
            Text( 'Menghapus Data...',),
            Center(child: new CircularProgressIndicator()),
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');

    var response = await http.post(
      Uri.https(env.apiUrl, 'api/kelitbangan/delete-bidang'),
      headers: {
        //'Content-Type' : 'aplication/json;',
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
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

  confirmDelete(){
    showDialog(context: context, builder: (BuildContext conf){
      updel = conf;
      return AlertDialog(
        title: Text( 'Akan Menghapus Data?' ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(updel).pop();
            delete();
          },
              child: Text('Ya',
              )),
          TextButton(onPressed: (){
            Navigator.of(updel).pop();
          },
              child: Text('Batal',
              )),
        ],
      );
    });
  }
}

