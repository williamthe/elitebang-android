import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/inovasi/baru.dart';
import 'package:prototype_litbang/inovasi/edit.dart';
import 'package:prototype_litbang/kelitbangan/view_kelitbangan.dart';
import 'package:prototype_litbang/myenv.dart';

class IndexInovasi extends StatefulWidget{
 @override
  _IndexInovasi createState() => _IndexInovasi();
}

class _IndexInovasi extends State<IndexInovasi>{
  List listData = [];

  int id = 0;
  String nomor = '';
  String tanggal = '';
  String nama = '';
  int instansi = 1;
  String tujuan = '';
  String manfaat = '';
  String hasil = '';
  String deskripsi = '';
  String kelengkapan = '';
  String pelaksana = '';
  int dokumen = 0;
  int curi = 1;

  late BuildContext simpan;
  Widget addControll = Container();

  Widget myList = Center(
      child: Text('Loading Data...'),
  );
  Widget awal = Text('');

  late BuildContext ex;
  late Widget laporan;
  MyEnvironments env = new MyEnvironments();


  String username = '';
  String password = '';

  String title = 'Inovasi';

  @override
  Widget build(BuildContext context) {
    laporan = ListView(
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
                    child: Text('Nomor',
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
                          setState(() {
                            nomor = e;
                          });
                        },
                        controller: TextEditingController(text: nomor),
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
                          setState(() {
                            tanggal = e;
                          });
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.abc_outlined)),
                        ),
                        minLines: 2,
                        maxLines: 10,
                        onChanged: (e){
                          setState(() {
                            var nama = e;
                          });
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
                    child: Text('Tujuan',
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
                          setState(() {
                            var tujuan = e;
                          });
                        },
                        controller: TextEditingController(text: tujuan),
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
                    child: Text('Manfaat',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.next_plan_outlined)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState(() {
                            var manfaat = e;
                          });
                        },
                        controller: TextEditingController(text: manfaat),
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
                    child: Text('Hasil',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){
                            var hasil = e;
                          });

                        },
                        controller: TextEditingController(text: hasil),
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
                    child: Text('Deskripsi',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){
                            var deskripsi = e;
                          });

                        },
                        controller: TextEditingController(text: deskripsi),
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
                    child: Text('Kelengkapan',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){
                            var kelengkapan = e;
                          });

                        },
                        controller: TextEditingController(text: kelengkapan),

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
                    child: Text('Pelaksana',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){
                            pelaksana = e;
                          });

                        },
                        controller: TextEditingController(text: pelaksana),
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

    final contentHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 7;

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
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Row(
                             children: [
                               Container(width: 20,),
                               Icon(Icons.list,size: 30, color: Colors.white,),
                               Container(child: Text(title,
                                 style: TextStyle(fontSize: 17,
                                     color: Colors.white

                                 ),
                               ),
                                 padding: EdgeInsetsDirectional.only(start: 8),),
                             ],
                           ),
                          addControll,
                         ],
                       ),
                       color: Colors.blue.shade800,),

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
                           BottomNavigationBarItem(icon: Icon(Icons.keyboard_double_arrow_left,color: Colors.black87,),label: 'Kembali'),
                           BottomNavigationBarItem(icon: Icon(Icons.view_list,color: Colors.black87,),label: 'Daftar'),
                           BottomNavigationBarItem(icon: Icon(Icons.book,color: Colors.black87,),label: 'Laporan'),
                           BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: Colors.black87,),label: 'Baru',),
                       ],
                       //selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black),
                       type: BottomNavigationBarType.fixed,
                       backgroundColor: CupertinoColors.white,
                       elevation: 0,
                       currentIndex: curi,
                       onTap: (value) {
                         switch(value){
                           case 0 : Navigator.of(context).pop(); break;
                           case 1 : getList(); break;
                           case 2 : setState(() {
                             curi = 2;
                             getLaporan();
                           }); break;
                           case 3 : setState(() {
                             curi = 3;
                             awal = FormBaru();
                           }); break;
                         }
                       },
                     ),
                   ],
                   ),
           ),
         ))
        );
  }

  Future<void> store() async {
    var _mytoken = await SessionManager().get('_token');
    var response = await http.post(
      Uri.https('api-litbang.btx.co.id', 'api/kelitbangan/create'),
      headers: {
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
        'nomor' : nomor,
        'tanggal' : tanggal,
        'lingkup' : instansi.toString(),
        'pelaksana' : jsonEncode(pelaksana.toString().split('\n')),
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
    nomor = '';
    tanggal = '';
    nama = '';
    tujuan = '';
    manfaat = '';
    pelaksana = '';
  }

  getList() async {
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    var response = await http.get(
      Uri.https(env.apiUrl, 'api/inovasi/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      setState(() {
        curi = 1;
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
                    child: Container(
                      alignment: Alignment.center,
                      child: Text((index+1).toString(), style: TextStyle(fontSize: 11, color: Colors.black), ),
                      width: 50,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listData[index]['nama'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: EdgeInsetsDirectional.all(3),
                              child: Text(listData[index]['instansi_data'] == null ? 'Instansi Tidak Ditemukan' : listData[index]['instansi_data']['nama'],
                                style: TextStyle(color: Colors.black38, fontSize: 11,overflow: TextOverflow.ellipsis),),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(border: Border(),
                          //color: Colors.black12
                        )
                    ),
                  ),
                  Expanded(child:
                  Container(child:
                    Text(listData[index]['tanggal'].toString().split("-")[0],style: TextStyle(
                       fontSize: 12
                    ),),
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
        addControll = Container();
      });
    }).whenComplete(( ) {
      setState(() {});
      Navigator.of(ex).pop();
    });

  }

  getLaporan() async {
    String _token = await SessionManager().get('_token');
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);

    var response = await http.get(
      Uri.https(env.apiUrl, 'api/pelaporan/list/inovasi'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer ${_token}',
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
                  showLaporan(listData[index]);
                },
                child: Row(children: [

                  Expanded(
                    flex: 5,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listData[index]['nama_inovasi'],
                              style: TextStyle(color: Colors.black,fontSize: 14, overflow: TextOverflow.ellipsis),),
                            Container(
                              padding: EdgeInsetsDirectional.all(3),
                              child: Text(listData[index]['nomor_sk_inovasi'],
                                style: TextStyle(color: Colors.black38, fontSize: 11),),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(border: Border(),
                          //color: Colors.black12
                        )
                    ),
                  ),
                  Expanded(child: Container(child: Text(listData[index]['tanggal_sk_inovasi'].toString(),
                  style: TextStyle(fontSize: 10),),
                  ))
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
        title = 'Laporan Inovasi';
        addControll = IconButton(onPressed: (){
          getUserLaporan();
        }, icon: Icon(Icons.people, color: Colors.white,), tooltip: 'List User Pelaporan',
        );
      });
    }).whenComplete(( ) {
      setState(() {});
      Navigator.of(ex).pop();
    });

  }

  getUserLaporan() async {
    String _mytoken = await SessionManager().get('_token');
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);

    await http.post(
        Uri.https(env.apiUrl, 'api/pelaporan/get/user-by-tipe'),
        headers: {
          'Authorization': 'Bearer ${_mytoken}'  },
        body: {
          'tipe' : 'inovasi'
        }
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
                  showLaporan(listData[index]);
                },
                child: Row(children: [

                  Expanded(
                    flex: 5,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listData[index]['username'],
                              style: TextStyle(color: Colors.black,fontSize: 14, overflow: TextOverflow.ellipsis),),
                            Container(
                              padding: EdgeInsetsDirectional.all(3),
                              child: Text(listData[index]['password'],
                                style: TextStyle(color: Colors.black38, fontSize: 11),),
                            ),
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
        title = 'User Laporan Inovasi';
        addControll = IconButton(onPressed: (){
          setState((){
            awal = Column(
              children: [

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
                            child: Text('Username',
                              style: TextStyle(fontSize: 14, color: Colors.black,

                              ),
                            ),
                            padding: EdgeInsetsDirectional.all(13),
                            decoration: BoxDecoration(
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
                                  username = e;
                                },
                                controller: TextEditingController(text: username),
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
                            child: Text('Password',
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

                                  }, icon: Icon(Icons.generating_tokens)),
                                ),
                                onChanged: (e){
                                  password = e;
                                },
                                controller: TextEditingController(text: password),
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
                                child: Text('Simpan',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,),),
                                onPressed: (){
                                  savePublicUser();
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
            title ='Tambah User Laporan Inovasi';
          });

        }, icon: Icon(Icons.person_add_alt_rounded, color: Colors.white,), tooltip: 'Tambah User Laporan',);
      });
    }).whenComplete(( ) {
      setState(() {});
      Navigator.of(ex).pop();
    });

  }

  showLaporan(data){
    Widget view_data = ListView(
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
                    child: Text('Nama SKPD',
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
                          setState(() {

                          });
                        },
                        controller: TextEditingController(text: data['nama_skpd']),
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
                    child: Text('Nama Unit',
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
                          setState(() {

                          });
                        },
                        controller: TextEditingController(text: data['nama_unit']),
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
                    child: Text('Nama Inovasi',
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
                          setState(() {

                          });
                        },
                        controller: TextEditingController(text: data['nama_inovasi']),
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
                    child: Text('Nomor SK Inovasi',
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
                          setState(() {

                          });
                        },
                        controller: TextEditingController(text: data['nomor_sk_inovasi']),
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
                    child: Text('Tanggal SK Inovasi',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.next_plan_outlined)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState(() {

                          });
                        },
                        controller: TextEditingController(text: data['tanggal_sk_inovasi']),
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
                    child: Text('Jumlah Pelaksana',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['jumlah_pelaksana_inovasi'].toString()),
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
                    child: Text('Inisiator Daerah',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['inisiator_daerah_inovasi']),
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
                    child: Text('Jenis Inovasi',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['jenis_inovasi']),

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
                    child: Text('Bentuk Inovasi',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['bentuk_inovasi']),
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
                    child: Text('Inovasi Tematik',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['inovasi_tematik']),
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
                    child: Text('Urusan Inovasi Daerah',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['urusan_inovasi_daerah']),
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
                    child: Text('Waktu Uji Coba',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['waktu_uji_coba']),
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
                    child: Text('Waktu Diterapkan',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['waktu_diterapkan']),
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
                    child: Text('Rancang Bangun',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['rancang_bangun']),
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
                    child: Text('Tujuan',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['tujuan']),
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
                    child: Text('Manfaat',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['manfaat']),
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
                    child: Text('Hasil',
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
                          suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                        ),
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (e){
                          setState((){

                          });

                        },
                        controller: TextEditingController(text: data['hasil']),
                      ),
                      decoration: BoxDecoration(border: Border(),
                        //color: Colors.black12
                      )
                  ),
                ),
              ],)
        ),
        Container(height: 10,),

      ],
    );
    setState(() {
      awal = Container(
          height: ((MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.8),
          child: view_data
      );
    });
  }

  savePublicUser() async {
    var _mytoken = await SessionManager().get('_token');
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(
        title: Center(child: new CircularProgressIndicator()),);
    },);
    await http.post(
        Uri.https(env.apiUrl, 'api/pelaporan/add-user'),
        headers: {
          'Authorization': 'Bearer ${_mytoken}'},
        body: {
          'tipe': 'inovasi',
          'username': username,
          'password': password
        }
    ).then((value) {
      var respon = jsonDecode(value.body);
      Navigator.of(ex).pop();
      print(respon);

      if (respon['status'] == true) {
        showDialog(context: ex, builder: (context) {
          return AlertDialog(
            title: Text('Berhasil!'),

          );
        });
      }
      else {
        showDialog(context: ex, builder: (context) {
          return AlertDialog(
            title: Text('Silahkan Login!'),
            content: Text(respon['message']),
          );
        });
      }
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

