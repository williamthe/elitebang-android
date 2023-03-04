import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:filesystem_picker/filesystem_picker.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/agenda/view.dart';
import 'package:prototype_litbang/sidenav.dart';

class Agenda extends StatefulWidget{
 @override
  _Agenda createState() => _Agenda();
}

class _Agenda extends State<Agenda>{
  List listData = [];

  String tanggal = '';
  String nama = '';
  String tempat = '';
  String waktu = '';

  Widget myList = Center(
      child: new CircularProgressIndicator(),
  );
  late BuildContext ref;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     //theme: CupertinoThemeData().,
     home: DefaultTabController(

       child: (
           Scaffold(
       appBar: AppBar(
         title: Text('Agenda'),
         centerTitle: true,
         bottom: TabBar(tabs: [
           Tab(
             icon: Icon(Icons.list_alt),
             text: 'List Data',

           ),
           Tab(
             child: Text('Tambah'),
             icon: Icon(Icons.add_circle),

           ),
         ],),
       ),
       drawer: Drawer(
         child: Sidenav(),
       ),
       body: TabBarView(
           children: [
         Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
           Container(
             height: MediaQuery.of(context).size.height -
                 AppBar().preferredSize.height -
                 MediaQuery.of(context).padding.top -150 * 0.9,
               child: myList
           ),
           SizedBox(height: 5,),
           Container(
             padding: EdgeInsetsDirectional.all(10),
             decoration: BoxDecoration(
               color: Colors.blue,
               borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),

             ),
             height: 50,
             width: 150,
             //color: Color.fromRGBO(0, 0, 100, 10),
             child: TextButton(onPressed: (){
                 showDialog(context: context, builder: (BuildContext con){
                   ref = con;
                   return AlertDialog(
                     title: Text( 'Mengambil Data...' ),
                     content: Text(""),
                   );
                 });
                 getList();

             }, child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [

                 Icon(Icons.refresh_outlined,color: Colors.white,size: 20,),
                 SizedBox(width: 5,),
                 Text('Refresh Data', style: TextStyle(color: Colors.white,fontSize: 15)),
                 //Text('Refersh Data', style: TextStyle(color: Colors.white)),

               ],
             ), ),
           ),
         ],),
         Container(
           height: 100,
           child: FormTambah(),
         ),

       ]),
     )),
        length: 2,
     )
    );
  }

  void showAgenda(listData) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ViewAgenda(listData);
    }));
  }

  getList() async {
    var response = await http.get(
      Uri.https('api-litbang.btx.co.id', 'api/agenda/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      setState((){
        myList = ListView.separated(itemBuilder: (context,index){
          return Container(
              padding: EdgeInsetsDirectional.all(10),
              height: 90,
              decoration: BoxDecoration(
                // border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white
              ),
              child:
              TextButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return ViewAgenda(listData[index]);
                  }));
                },
                child: Row(children: [
                  Container(

                    child: Text((index+1).toString(), style: TextStyle(fontSize: 15, color: Colors.black), ),
                    width: 50,
                    padding: EdgeInsets.all(20),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      // color: Colors.black38,
                        borderRadius: BorderRadiusDirectional.circular(20)
                    ),
                  ),
                  Container(
                      padding: EdgeInsetsDirectional.all(10),
                      child: Text(listData[index]['nama'],style: TextStyle(color: Colors.black),),
                      decoration: BoxDecoration(border: Border()
                      )
                  ),
                  Container()
                ],),
              )
          );
        },
          separatorBuilder: (context, index) => SizedBox(height: 3,),
          itemCount:listData.length,
        );
      });
      Navigator.of(ref).pop();

    });

  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        getList();
      });
    });
  }

}

class FormTambah extends StatefulWidget{
  @override
  State<FormTambah> createState() => _FormTambahState();
}

class _FormTambahState extends State<FormTambah> {
  int id = 0;
  String tanggal = '';
  String nama = '';
  String tempat = '';
  String waktu = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 20,),
        Container(
          padding: EdgeInsetsDirectional.all(8),
            alignment: Alignment.centerLeft,
            child: Text("Agenda : ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
        Expanded(
          flex: 7,
          child: Container(
            padding: EdgeInsetsDirectional.all(15),
            color: CupertinoColors.white,
            child: Row(
              children: [
                Icon(Icons.title, size: 28,),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 10),
                  width: 330,
                  child: TextField(
                    minLines: 2,
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    onChanged: (e){
                      nama = e;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(flex: 1, child: Container(height: 10,),),
        Container(
            padding: EdgeInsetsDirectional.all(8),
            alignment: Alignment.centerLeft,
            child: Text("Tempat : ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
        Expanded(
          flex: 7,
          child: Container(
            padding: EdgeInsetsDirectional.all(15),
            color: CupertinoColors.white,
            child: Row(
              children: [
                Icon(Icons.place, size: 28,),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 10),
                  width: 330,
                  child: TextFormField(
                    decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    onChanged: (e){
                      tempat = e;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(flex: 1, child: Container(height: 10,),),
        Container(
            padding: EdgeInsetsDirectional.all(8),
            alignment: Alignment.centerLeft,
            child: Text("Tanggal : ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
        Expanded(
          flex: 7,
          child: Container(
            color: CupertinoColors.white,
            padding: EdgeInsetsDirectional.all(15),
            child: Row(
              children: [
                Icon(Icons.date_range, size: 28,),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 10),
                  width: 330,
                  child: TextFormField(
                    controller: TextEditingController(text: tanggal),
                    onChanged: (e){
                      tanggal = e;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        suffixIcon: IconButton(onPressed: (){
                          showDatePicker(context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1990),
                              lastDate: DateTime(2099)
                          ).then((value) {
                            setState(() {
                              tanggal = value == null ? '' : value.toString().split(" ")[0];
                            });
                          });
                        },icon: Icon(Icons.date_range),),
                      
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(flex: 1, child: Container(height: 10,),),
        Container(
            padding: EdgeInsetsDirectional.all(8),
            alignment: Alignment.centerLeft,
            child: Text("Waktu : ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
        Expanded(
          flex: 7,
          child: Container(
            color: CupertinoColors.white,
            padding: EdgeInsetsDirectional.all(15),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 28,),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 10),
                  width: 330,
                  child: TextFormField(
                    controller: TextEditingController(text: waktu),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: (){
                        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                          setState(() {
                            waktu = value == null ? '' : value.toString().substring(10,15);
                          });
                        });
                      },icon: Icon(Icons.access_time),),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onChanged: (e){
                      waktu = e;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(flex: 1, child: Container(height: 10,),),
        Expanded(
          flex: 8,
          child: Container(
            padding: EdgeInsetsDirectional.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                      borderRadius: BorderRadiusDirectional.circular(10)
                    ),
                  width: 150,
                  child:
                  TextButton(onPressed: (){
                    store();
                  }, child: Text('Save',style: TextStyle(color: CupertinoColors.white),))
                )
              ],
            ),
          ),
        ),

      ],
    );


  }
  Future<void> store() async {
    var _mytoken = await SessionManager().get('_token');
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text( 'Silahkan Tunggu...' ),
        content: Text(""),
      );
    });
    var response = await http.post(
      Uri.https('api-litbang.btx.co.id', 'api/agenda/create'),
      headers: {
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        // 'id' : id.toString(),
        'tanggal' : tanggal,
        'nama' : nama,
        'waktu' : waktu,
        'tempat' : tempat,
      },
    ).then((value){
      var dec = jsonDecode(value.body);
      Navigator.of(context).pop();
      if(dec['status'] == true){
        showDialog(context: context, builder: (context){
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

  resetForm() {
    tanggal = '';
  }


}

