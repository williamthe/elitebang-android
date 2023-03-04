import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:prototype_litbang/agenda/edit.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:prototype_litbang/kelitbangan/edit_kelitbangan.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;

import 'index.dart';

class ViewAgenda extends StatefulWidget{
  Map myData = {};
  ViewAgenda(listData){
    this.myData = listData;
  }

  _ViewAgenda createState() => _ViewAgenda(myData);

}

class _ViewAgenda extends State<ViewAgenda>{
  Map myData = {};
  String pelaksana = '';
  _ViewAgenda(Map myData){
    this.myData = myData;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          appBar: AppBar(title: Text(myData['nama'],),
            centerTitle: true,
            leading: IconButton(onPressed: (){
              Navigator.of(context).pop();
            },icon: Icon(Icons.arrow_circle_left),),
          ),
          body:
          Column(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.9,
                child: Datas(myData)),
              Container(
                padding: EdgeInsetsDirectional.all(13),
                height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.1,
                  child: MyActions(myData))
            ],
          ),
        )
    );
  }

  myListData(listData){
    return ListView.separated(itemBuilder: (context,index){

      return Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          selectedTileColor: Colors.blue,
          leading: CircleAvatar(
            child: Text((index+1).toString()),
            //backgroundColor: Colors.transparent,
            //foregroundColor: Colors.blue,

          ),
          title: Text(listData[index]['judul'].toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,),
          ),
          subtitle: Text(listData[index]['abstrak'].toString()),
          trailing: Column(
            children: [
            ],
          ),
          onTap: (){
            //showLitbang(listData[index]);
          },
          style: ListTileStyle.drawer,

        ),
      );
    },
      separatorBuilder: (context, index) => SizedBox(height: 3,),
      itemCount:listData.length,
    );;
  }

  Future<void> deleteData(id) async {
    var _mytoken = await SessionManager().get('_token');
    Navigator.of(context).pop();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text( 'Silahkan Tunggu...' ),
        content: Text(""),
      );
    });
    var response = await http.post(
      Uri.https('api-litbang.btx.co.id', 'api/agenda/delete'),
      headers: {
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
      },
    ).then((value){
      var dec = jsonDecode(value.body);
      Navigator.of(context).pop();
      if(dec['status'] == true){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Data Berhasil Terhapus!'),
            content: Text(""),
          );
        }).then((value) => Navigator.of(context).pop());
      }
      else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Data Gagal Terhapus!'),
            content: Text(dec['message']),
          );
        }).then((value) => Navigator.of(context).pop());
      }

    } );

  }

}

class Datas extends StatelessWidget{
  Map myData = {};

  Datas(this.myData);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top ) * 0.9,
      child: MyView(myData)
      // ListView(
      //   children: [
      //
      //     ListTile(
      //       title: Text('Nama',style: TextStyle(fontWeight: FontWeight.bold)),
      //       subtitle: Text(myData['nama'] == null ? '-' : myData['nama']),
      //     ),
      //     ListTile(
      //       title: Text('Tanggal',style: TextStyle(fontWeight: FontWeight.bold)),
      //       subtitle: Text(myData['tanggal'] == null ? '-' : myData['tanggal']),
      //     ),
      //     ListTile(
      //       title: Text('Waktu',style: TextStyle(fontWeight: FontWeight.bold)),
      //       subtitle: Text(myData['waktu'] == null ? '-' : myData['waktu']),
      //     ),
      //     ListTile(
      //       title: Text('Tempat',style: TextStyle(fontWeight: FontWeight.bold)),
      //       subtitle: Text(myData['tempat'] == null ? '-' : myData['tempat']),
      //     ),
      //   ],
      // ),
    );
  }

}

class MyActions extends StatelessWidget{
  Map myData = {};

  MyActions(this.myData);
  @override
  Widget build(BuildContext context) {
    return Container(
     // color: Color.fromRGBO(33, 150, 243, 1),
      //padding: EdgeInsetsDirectional.all(13),
      //height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.1,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          padding: EdgeInsetsDirectional.all(3),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
          ),
          height: 70,
          width: 75,
          //color: Color.fromRGBO(0, 0, 100, 10),
          child: TextButton(onPressed: (){
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            //   return EditAgenda(myData);
            // },));
          }, child: Row(
            children: [

              Icon(Icons.edit,color: Colors.white,size: 15,),
              SizedBox(width: 5,),
              Text('Edit', style: TextStyle(color: Colors.white,fontSize: 15)),

            ],
          ), ),
        ),
        SizedBox(width: 5,),
        Container(
          padding: EdgeInsetsDirectional.all(3),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),

          ),
          height: 70,
          width: 88,
          //color: Color.fromRGBO(0, 0, 100, 10),
          child: TextButton(onPressed: (){
            showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation) {
              return AlertDialog(
                title: Text('Yakin Menghapus Data?'),
                actions: [
                  IconButton(onPressed: (){
                    //deleteData(myData['id']);
                  }, icon: Icon(Icons.check_circle)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.cancel)),
                ],
              );
            },);
          }, child: Row(
            children: [

              Icon(Icons.delete,color: Colors.white, size: 15,),
              SizedBox(width: 5,),
              Text('Delete', style: TextStyle(color: Colors.white,fontSize: 15)),

            ],
          ), ),
        ),
        //Container(child: IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.white,)))
      ],
    ),);
  }

}

class MyView extends StatelessWidget{
  Map myData = {};
  MyView(Map data){
    this.myData = data;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(20),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsetsDirectional.all(20),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadiusDirectional.circular(25)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(myData['nama'],
                    style: TextStyle(color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                        //overflow: TextOverflow.ellipsis,
                    )
                    ,),
                ],
              ),
            ),
          ),
          Container(height: 10,),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsetsDirectional.all(30),
              decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadiusDirectional.circular(25)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(child: Icon(Icons.place, size: 50,)),
                      Container(
                          padding: EdgeInsetsDirectional.only(start: 20),
                          child: Text(myData['tempat'],
                            style: TextStyle(color: Colors.black87,
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                            )
                            ,)
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          Container(height: 10,),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsetsDirectional.all(30),
              decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadiusDirectional.circular(25)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(child: Icon(Icons.date_range, size: 50,)),
                      Container(
                          padding: EdgeInsetsDirectional.only(start: 20),
                          child: Text(myData['tanggal'],
                            style: TextStyle(color: Colors.black87,
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            )
                            ,)
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          Container(height: 10,),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsetsDirectional.all(30),
              decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadiusDirectional.circular(25)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(child: Icon(Icons.access_time_outlined, size: 50,)),
                      Container(
                        padding: EdgeInsetsDirectional.only(start: 20),
                          child: Text(myData['waktu'],
                            style: TextStyle(color: Colors.black87,
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            )
                            ,)
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(border: Border()
      )
    );
  }
}

