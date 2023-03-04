import 'dart:convert';
//import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:filesystem_picker/filesystem_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
// import 'baru.dart';
import 'package:prototype_litbang/myenv.dart';
import 'package:prototype_litbang/usulan-inovasi/edit_penelitian.dart';
import 'package:prototype_litbang/kelitbangan/view_kelitbangan.dart';

class IndexUsulanInovasi extends StatefulWidget{
  @override
  _IndexUsulanInovasi createState() => _IndexUsulanInovasi();
}

class _IndexUsulanInovasi extends State<IndexUsulanInovasi>{
  List listData = [];

  late BuildContext simpan;
  MyEnvironments env = new MyEnvironments();

  Widget myList = Center(
    child: Text('Loading Data...'),
  );
  Widget awal = Text('');

  late BuildContext ex;

  @override
  Widget build(BuildContext context) {
    final contentHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 7;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: env.myFont),
        home: DefaultTabController(
          child: (
              Scaffold(
                resizeToAvoidBottomInset : false,
                body: Column(
                  children: [
                    Container(height: (contentHeight *0.13),
                      padding: EdgeInsetsDirectional.only(top: 30),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(width: 40,),
                          Icon(Icons.list,size: 30,),
                          Container(child: Text('Usulan Inovasi',
                            style: TextStyle(fontSize: 17,

                            ),
                          ),
                            padding: EdgeInsetsDirectional.only(start: 8),),
                        ],
                      ),
                      color: CupertinoColors.white,),
                    Container(
                      //color : Colors.black,
                      height: (contentHeight *0.82),
                      //padding: EdgeInsetsDirectional.only(top: 10),
                      child: TabBarView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        height: (contentHeight * 0.8),
                                        child: awal
                                    ),
                                  ],
                                ),
                              ],),
                          ]),
                    ),

                    //NavigationDestination(icon: icon, label: label,),
                    BottomNavigationBar(
                      iconSize: 25,
                      items: [
                        BottomNavigationBarItem(icon: Icon(Icons.keyboard_double_arrow_left),label: 'Kembali'),
                        BottomNavigationBarItem(icon: Icon(Icons.filter_list),label: 'Daftar'),
                        BottomNavigationBarItem(icon: Icon(Icons.add_circle),label: 'Baru',),
                      ],
                      backgroundColor: CupertinoColors.white,
                      elevation: 0,
                      //currentIndex: 1,
                      onTap: (value) {
                        switch(value){
                          case 0 : Navigator.of(context).pop(); break;
                          case 1 : getList(); break;
                          case 2 : setState(() {
                           // awal = FormBaru();
                          });;
                        }

                      },
                    ),
                  ],
                ),


                // floatingActionButton: FloatingActionButton(onPressed:(){},
                //   child: Icon(Icons.add_circle),),
              )),
          length: 1,
        )
    );
  }

  Future<void> store() async {
    var _mytoken = await SessionManager().get('_token');
    await http.post(
      Uri.https(env.apiUrl, 'api/kelitbangan/create'),
      headers: {
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {

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

  void showLitbang(listData) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ViewKelitbangan(listData);
    }));
  }

  resetForm() {

  }

  getList() async {
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    await http.get(
      Uri.https(env.apiUrl, 'api/usulan-inovasi/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      setState(() {
        myList = ListView.separated(itemBuilder: (context,index){
          return Container(
              padding: EdgeInsetsDirectional.all(10),
              height: 135,
              decoration: BoxDecoration(
                // border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white
              ),
              child:
              TextButton(
                onPressed: (){
                  setState(() {
                    awal = FormEdit(listData[index]);
                  });
                },
                child: Row(children: [
                  // Container(
                  //   alignment: Alignment.center,
                  //   child: Text((index+1).toString(), style: TextStyle(fontSize: 14, color: Colors.black), ),
                  //   width: 60,
                  //   padding: EdgeInsets.all(5),
                  //   //color: Colors.lightBlue,
                  //   decoration: BoxDecoration(
                  //       color: Colors.black12,
                  //       borderRadius: BorderRadiusDirectional.circular(20)
                  //   ),
                  // ),
                  Expanded(
                    flex:6,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listData[index]['usulan'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                overflow: TextOverflow.ellipsis
                              ),
                            ),
                            Container(
                              padding: EdgeInsetsDirectional.all(2),
                              child: Text(listData[index]['pengusul'] == null ? '-' : listData[index]['pengusul'],
                                style: TextStyle(color: Colors.black54, fontSize: 12,
                                    overflow: TextOverflow.ellipsis),),
                            ),
                            Text(listData[index]['status'] == null ? '-' : listData[index]['status'],
                              style: TextStyle(color: Colors.black38, fontSize: 10),),
                          ],
                        ),
                        decoration: BoxDecoration(border: Border(),
                          //color: Colors.black12
                        )
                    ),
                  ),

                ],),
              )
          );
        },
          separatorBuilder: (context, index) => Container(height: 13,
            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
          ),
          itemCount:listData.length,
        );
        awal = myList;
      });
    }).whenComplete(( ) {
      setState(() {});
      Navigator.of(ex).pop();
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

