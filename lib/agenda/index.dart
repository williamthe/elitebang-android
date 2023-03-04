import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'edit.dart';
import 'tambah.dart';
import '../myenv.dart';

class IndexAgenda extends StatefulWidget{
  @override
  _IndexAgenda createState() => _IndexAgenda();
}

class _IndexAgenda extends State<IndexAgenda>{
  MyEnvironments env = new MyEnvironments();
  List listData = [];
  late BuildContext simpan;

  Widget myList = Center(
    child: Center(child: new CircularProgressIndicator()),
  );
  Widget awal = Container();

  late BuildContext ex;

  @override
  Widget build(BuildContext context) {
    final contentHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top -7;
    return MaterialApp(
      theme: ThemeData(fontFamily: env.myFont),
        debugShowCheckedModeBanner: false,
        home: (
            Scaffold(
              //resizeToAvoidBottomInset : false,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: (contentHeight *0.13),
                      padding: EdgeInsetsDirectional.only(top: 30),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(width: 40,),
                          Icon(Icons.list,size: 30,),
                          Expanded(
                            child: Container(
                              child: Text('Agenda',
                                style: TextStyle(fontSize: 17,

                                ),
                              ),
                              padding: EdgeInsetsDirectional.only(start: 8),),
                          ),
                        ],
                      ),
                      color: CupertinoColors.white,),
                    Container(
                      //color : Colors.black,
                      height: (contentHeight *0.82),
                      //padding: EdgeInsetsDirectional.only(top: 10),
                      child: Column(
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
                      currentIndex: 1,
                      onTap: (value) {
                        switch(value){
                          case 0 : Navigator.of(context).pop(); break;
                          case 1 : getList(); break;
                          case 2 : setState(() {
                            awal = FormTambah();
                          });;
                        }

                      },
                    ),
                  ],
                ),
              ),
            ))
    );
  }

  getList() async {
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    var response = await http.get(
      Uri.https(env.apiUrl, 'api/agenda/list'),
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
              height: 100,
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
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text((index+1).toString(), style: TextStyle(fontSize: 11, color: Colors.black), ),
                      width: 50,
                      padding: EdgeInsets.all(20),
                      //color: Colors.lightBlue,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                    ),
                  ),
                  Expanded(
                    flex:11,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(listData[index]['nama'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),),
                            ),
                            Flexible(
                              //padding: EdgeInsetsDirectional.all(3),
                              child: Text(listData[index]['tempat'] == null ? '-' : listData[index]['tempat'],
                                style: TextStyle(color: Colors.black38, fontSize: 11,
                                    overflow: TextOverflow.ellipsis),),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(border: Border(),
                          //color: Colors.black12
                        )
                    ),
                  ),
                  Expanded(
                      flex:3,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(listData[index]['tanggal'].toString(),
                              style: TextStyle(

                                fontSize: 10,
                              ),
                            ),
                            Text(listData[index]['waktu'].toString().substring(0,5),
                              style: TextStyle(

                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      )
                  )
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

